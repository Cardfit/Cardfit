//
//  CardEntity.swift
//  Cardfit
//
//  Created by 서동운 on 9/17/23.
//
import Foundation
import RealmSwift

public final class UserCardEntity: Object {
    @Persisted var cards: List<CardEntity>
    
    convenience init(cards: List<CardEntity>) {
        self.init()
        
        self.cards = cards
    }
}

public final class CardEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var benefits: Data
    @Persisted var cardImageURL: String?
    @Persisted var cardName: String
    @Persisted var cardNumber: String
    @Persisted var company: String?
    @Persisted var domesticAnnualFee: String?
    @Persisted var imageData: Data?
    @Persisted var mainBenefit: String?
    @Persisted var requiredPreviousMonthUsage: Int?
    
    convenience init(benefits: Data = Data(), cardImageURL: String? = nil, cardName: String = String(), cardNumber: String = String(), company: String? = nil, domesticAnnualFee: String? = nil, imageData: Data? = nil, mainBenefit: String? = nil, requiredPreviousMonthUsage: Int?) {
        
        self.init()

        self.benefits = benefits
        self.cardImageURL = cardImageURL
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.company = company
        self.domesticAnnualFee = domesticAnnualFee
        self.imageData = imageData
        self.mainBenefit = mainBenefit
        self.requiredPreviousMonthUsage = requiredPreviousMonthUsage
    }
    
    func toDomain() -> Card {
        return Card(objectId: _id, cardName: cardName, cardNumber: cardNumber, cardImageURL: cardImageURL, imageData: imageData, domesticAnnualFee: domesticAnnualFee, requiredPreviousMonthUsage: requiredPreviousMonthUsage, mainBenefit: mainBenefit, company: company, benefit: decodedBenefits())
    }
    
    func decodedBenefits() -> Benefits? {
        return JSONCoder.shared.decode(type: Benefits.self, from: benefits)
    }
}

