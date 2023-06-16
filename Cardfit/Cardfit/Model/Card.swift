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
    var domesticAnnualFee: String?
    var requiredPreviousMonthUsage: Int64?
    var mainBenefit: String?
    var company: String?
    var benefit: Benefits?
    var offset: CGFloat? = 0
}

typealias Benefits = [[String: [String: String]]]
