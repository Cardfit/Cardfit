//
//  Card.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import Foundation

struct Card: Identifiable, Hashable, Codable {
    var id: Int?
    var cardName: String?
    var cardNumber: String?
    var cardImageURL: String?
    var imageData: Data?
    var domesticAnnualFee: String?
    var requiredPreviousMonthUsage: Int64?
    var mainBenefit: String?
    var company: String?
    var benefit: Benefits?
    var offset: CGFloat? = 0
}

extension Card {
    static func placeholder() -> Card {
        Card(cardName: "카드핏 카드", cardNumber: "1111", domesticAnnualFee: "15,000원", requiredPreviousMonthUsage: 300_000, mainBenefit: "카드핏 카드 메인혜택", company: "Cardfit", benefit: [
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
