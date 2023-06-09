//
//  CardListViewModel.swift
//  Cardfit
//
//  Created by 서동운 on 6/9/23.
//

import Foundation
import CoreData

class CardListViewModel: ObservableObject {
    
    @Published var cardList: [CardEntity] = []
    
//    @State var selectedCards: [Card]
    
    var company: CompanyList
    
    init(company: CompanyList) {
        self.company = company
    }
    
    func fetchCardList() async -> Result<[CardEntity], Error> {

        do {
            var entities = try PersistenceController.shared.fetchCardEntities(for: company)
            
            if entities.isEmpty {
                let cardList = try await FirebaseManager.shared.fetchCardInfo(of: company)
                
                PersistenceController.shared.changeToCardEntity(from: cardList)
                PersistenceController.shared.save()
                
                entities = try PersistenceController.shared.fetchCardEntities(for: company)
            }
            
            return .success(entities)
        } catch {
            return .failure(error)
        }
    }
    
    func removeCardEntity() {
        PersistenceController.shared.resetCardEntity()
    }
}
