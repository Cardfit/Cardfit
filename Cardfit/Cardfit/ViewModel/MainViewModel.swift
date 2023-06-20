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
    
    func fetchUserCardList() async -> [Card] {
        do {
            let userCardEntity = try PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first
            guard let cardsSet = userCardEntity?.cards else { return [] }
            var cardEntities = [CardEntity]()
            if let cardsArray = cardsSet.allObjects as? [CardEntity] {
                // CardEntity 배열을 사용하여 원하는 작업을 수행합니다.
                for card in cardsArray {
                    cardEntities.append(card)
                }
            }
            
            let cards = cardEntities.map { cardEntity in
                return Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber, cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: nil)
            }
            return cards
        } catch {
            print(error)
            return []
        }
    }
}
