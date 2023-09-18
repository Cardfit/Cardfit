//
//  CardListViewModel.swift
//  Cardfit
//
//  Created by 서동운 on 6/9/23.
//

import Foundation

class CardListViewModel: ObservableObject {
    @Published var cardList: [Card] = []
    @Published var selectedCards: [Card] = []
    
    private var lastCardNumber: String? {
        return cardList.last?.cardNumber
    }
    
    private var cardNumberOnServer: Int = 0
    private var isFirstLoading = true
    
    let company: CompanyList
    
    init(company: CompanyList) {
        self.company = company
    }
    
    func getCardCountOnServer() async {
        self.cardNumberOnServer = await FirebaseManager.shared.getTotalCountOfCard(of: company)
    }
    
    @MainActor
    func fetchCardList(onSuccess: () -> Void, complete: () -> Void) async {
        
        do {
            let cards = Repository.shared.fetchFilteredCards { $0.company == company.rawValue }
            let sortedCards = cards.sorted(by: {$0.cardNumber > $1.cardNumber})
            if sortedCards.count != cardNumberOnServer {
                var fetchedCards = try await FirebaseManager.shared.fetchCardInfo(of: company, after: lastCardNumber)
                if !isFirstLoading {
                    fetchedCards.removeFirst()
                } else {
                    isFirstLoading = false
                }
                
                Repository.shared.saveCards(fetchedCards)
                cardList.append(contentsOf: fetchedCards)
                onSuccess()
            } else if lastCardNumber == sortedCards.last?.cardNumber {
                onSuccess()
                complete()
                return
            } else {
                cardList.append(contentsOf: sortedCards)
                onSuccess()
            }
        } catch {
            print(error)
        }
    }
    
    func removeCardEntity() {
        Repository.shared.deleteFilteredCards { $0.company == company.rawValue }
    }
}
