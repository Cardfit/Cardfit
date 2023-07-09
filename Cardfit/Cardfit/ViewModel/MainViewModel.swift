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
    @Published var image: [Image] = []
    
    func fetchUserCardList() async -> Result<[Card], CardfitError> {
        guard let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first else { return .failure(.empty) }
        let cards = userCardEntity.convertToCards()
        return .success(cards)
    }
}
