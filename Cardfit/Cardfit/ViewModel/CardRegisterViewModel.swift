//
//  CardRegisterViewModel.swift
//  Cardfit
//
//  Created by 서동운 on 9/17/23.
//

import Foundation

class CardRegisterViewModel: ObservableObject {
    let selectedCards: [Card]
    
    init(selectedCards: [Card]) {
        self.selectedCards = selectedCards
    }
    
    func saveCards() {
        if !selectedCards.isEmpty {
            Task(priority: .background) {
                Repository.shared.saveUserCards(selectedCards)
            }
        }
    }
}
