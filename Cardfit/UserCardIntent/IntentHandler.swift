//
//  IntentHandler.swift
//  UserCardIntent
//
//  Created by 서동운 on 6/25/23.
//

import Intents
import WidgetKit

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any? {
        return self
    }
}

extension IntentHandler: ConfigurationIntentHandling {
    func defaultMyCard(for intent: ConfigurationIntent) -> MyCard? {
        
        guard let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self).first else {
            let card = Card.placeholder()
            return MyCard(identifier: nil, display: card.cardName ?? String(), pronunciationHint: card.cardName)
        }
        
        let userCards = userCardEntity.convertToCards()
        
        if userCards.isEmpty {
            return MyCard(identifier: nil, display: Card.placeholder().cardName ?? String(), pronunciationHint: nil)
        } else {
            return nil
        }
    }
    
    func provideMyCardOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<MyCard> {
        
        let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self).first!
        let userCards = userCardEntity.convertToCards()
        
        var userCardsINOs = [MyCard]()
        
        userCards.forEach { card in
            userCardsINOs.append(MyCard(identifier: nil, display: card.cardName ?? String(), pronunciationHint: card.cardName ?? String()))
        }
        let collection = INObjectCollection(items: userCardsINOs)
        return collection
    }
}
