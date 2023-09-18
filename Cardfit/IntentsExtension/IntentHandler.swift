//
//  IntentHandler.swift
//  IntentsExtension
//
//  Created by 서동운 on 9/18/23.
//

import Intents

class IntentHandler: INExtension, CardIntentHandling {
    
    func provideParameterOptionsCollection(for intent: CardIntent) async throws -> INObjectCollection<UserCard> {
        
        let userCards = await Repository.shared.fetchUserCards()
        
        let items: [UserCard] = userCards.compactMap { cardData in
            let card = UserCard(identifier: cardData.objectId?.stringValue, display: cardData.cardName, pronunciationHint: cardData.cardName, subtitle: cardData.company, image: INImage(imageData: cardData.imageData ?? Data()))
            return card
        }
        
        let collection = INObjectCollection(items: items)
        return collection
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
