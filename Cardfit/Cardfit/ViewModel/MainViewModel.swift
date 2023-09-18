//
//  CarouselViewModel.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var swipedCard = 0
    
    // Detail Content....
    
    @Published var showCard = false
    @Published var selectedCard : Card?
    @Published var selectedColor : Color = .clear
    @Published var showContent = false
    @Published var image: [Image] = []
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init() {
        
        $cards.sink { cards in
            cards.forEach { card in
                if let imageData = card.imageData,
                   let image = UIImage(data: imageData) {
                    self.image.append(Image(uiImage: image))
                }
            }
        }.store(in: &anyCancellable)
    }
    
    @MainActor
    func fetchUserCardList() {
        let result = Repository.shared.fetchUserCards()
        switch result {
        case .success(let cards):
            self.cards = cards
        case .failure(let error):
            print(error)
        }
    }
}
