//
//  UserCardEntityExtension.swift
//  Cardfit
//
//  Created by 서동운 on 6/22/23.
//

import Foundation

extension UserCardEntity {
    func convertToCards() -> [Card] {
        guard let cardsSet = self.cards else { return [] }
        var cardEntities = [CardEntity]()
        
        guard let cardsArray = cardsSet.allObjects as? [CardEntity] else { return [] }
        
        for card in cardsArray {
            cardEntities.append(card)
        }
        
        let cards = cardEntities.map { cardEntity in
            return Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber, cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: nil)
        }
        return cards
    }
}
