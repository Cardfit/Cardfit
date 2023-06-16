//
//  CarouselViewModel.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

class MainViewModel: ObservableObject{
    @Published var cards: [Card] = []
    @Published var swipedCard = 0
    
    // Detail Content....
    
    @Published var showCard = false
    @Published var selectedCard : Card = Card()
    @Published var selectedColor : Color = .clear
    @Published var showContent = false
    
    public init(){
        if cards.isEmpty{
            Task(priority: .background){
                var cards = await fetchCardList()
                self.cards = cards ?? []   
            }
        }
        
    }
    
    func fetchCardList() async -> [Card]? {

            do {
                var entities = try PersistenceController.shared.fetchCardEntities(for: .bc)
                
                if entities.isEmpty {
                    let cardList = try await FirebaseManager.shared.fetchCardInfo(of: .bc)
                    
                    PersistenceController.shared.changeToCardEntity(from: cardList)
                    PersistenceController.shared.save()
                    
                    entities = try PersistenceController.shared.fetchCardEntities(for: .bc)
                }
                
                let cards = entities.map { cardEntity in
                    Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber, cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company)
                }
                
                return cards
            } catch {
                print(error)
                return nil
            }
        }
    
    
}
