//
//  Card.swift
//  Cardfit
//
//  Created by 서동운 on 9/17/23.
//

import Foundation
import RealmSwift

public struct Card: Identifiable, Hashable, Codable {
    public var objectId: ObjectId?
    public var id: Int?
    var cardName: String
    var cardNumber: String
    var cardImageURL: String?
    var imageData: Data?
    var domesticAnnualFee: String?
    var requiredPreviousMonthUsage: Int?
    var mainBenefit: String?
    var company: String?
    var benefit: Benefits?
    var offset: CGFloat? = 0
    
    init(objectId: ObjectId?, id: Int? = nil,cardName: String = String(), cardNumber: String = String(), cardImageURL: String? = nil, imageData: Data? = nil, domesticAnnualFee: String? = nil, requiredPreviousMonthUsage: Int? = nil, mainBenefit: String? = nil, company: String? = nil, benefit: Benefits? = nil, offset: CGFloat? = nil) {
        self.objectId = objectId
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.cardImageURL = cardImageURL
        self.imageData = imageData
        self.domesticAnnualFee = domesticAnnualFee
        self.requiredPreviousMonthUsage = requiredPreviousMonthUsage
        self.mainBenefit = mainBenefit
        self.company = company
        self.benefit = benefit
        self.offset = offset
    }
    
    func toEntity() -> CardEntity {
        return CardEntity(benefits: encodedBenefits(), cardImageURL: cardImageURL, cardName: cardName, cardNumber: cardNumber, company: company, domesticAnnualFee: domesticAnnualFee, imageData: imageData, mainBenefit: mainBenefit, requiredPreviousMonthUsage: requiredPreviousMonthUsage)
    }
    
    func encodedBenefits() -> Data {
        let data = JSONCoder.shared.encode(value: benefit)
        return data
    }
}

extension Card {
    static func placeholder() -> Card {
        Card(objectId: ObjectId.generate(), cardName: "카드핏 카드", cardNumber: "1111", domesticAnnualFee: "15,000원", requiredPreviousMonthUsage: 300_000, mainBenefit: "카드핏 카드 메인혜택", company: "Cardfit", benefit: [
            ["1": ["category": "간편결제",
                   "title":"간편결제시 10% 할인",
                   "description": "카드핏에서 간편결제시 10%할인"]],
            ["21": ["category": "주유",
                    "title": "주유 시 리터 당 60원 적립",
                    "description": "주유 시 리터 당 60원 적립"]],
            ["6": ["title": "가맹점 추가 적립",
                   "category": "금융",
                   "description": "가맹점 추가 적립"]]])
    }
}

typealias Benefits = [[String: [String: String]]]
