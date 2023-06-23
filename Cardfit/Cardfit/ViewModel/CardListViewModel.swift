//
//  CardListViewModel.swift
//  Cardfit
//
//  Created by 서동운 on 6/9/23.
//

import Foundation

class CardListViewModel: ObservableObject {
    @Published var cardList: [Card] = []
    @Published var selectedCards: [Card] = []
    
    var company: CompanyList
    
    init(company: CompanyList) {
        self.company = company
    }
    
    func fetchCardList() async -> Result<[Card], Error> {
        do {
            
            let entities = PersistenceController.shared.fetchData(entity: .cardEntity, entityType: CardEntity.self, predicate: NSPredicate(format: "company == %@", company.rawValue))
            
            if entities.isEmpty {
                let cardList = try await FirebaseManager.shared.fetchCardInfo(of: company)
                
                PersistenceController.shared.saveMulitpleData(datas: cardList, entityType: CardEntity.self) { (data, entity) in
                    
                    entity.setValue(data.cardName, forKey: "cardName")
                    entity.setValue(data.cardNumber, forKey: "cardNumber")
                    entity.setValue(data.company, forKey: "company")
                    entity.setValue(data.mainBenefit, forKey: "mainBenefit")
                    entity.setValue(data.domesticAnnualFee, forKey: "domesticAnnualFee")
                    entity.setValue(data.requiredPreviousMonthUsage, forKey: "requiredPreviousMonthUsage")
                    
                    let benefit = try? JSONEncoder().encode(data.benefit)
                    entity.setValue(benefit, forKey: "benefit")
                }
                
                return .success(cardList)
            } else {
                let cards = try entities.map { cardEntity in
                    let benefit = try JSONDecoder().decode(Benefits.self, from: cardEntity.benefit ?? Data())
                    let card = Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber ?? String(), cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: benefit)
                   
                    return card
                }
                return .success(cards)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func removeCardEntity() {
        PersistenceController.shared.deleteData(entity: .cardEntity)
    }
}
