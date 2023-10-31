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
    
    private var anyCancellable = Set<AnyCancellable>()
    
    @MainActor
    func fetchUserCardList() {
        let cards = Repository.shared.fetchUserCards()
        self.cards = cards
    }
}
