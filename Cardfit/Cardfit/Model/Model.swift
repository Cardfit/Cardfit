//
//  Card.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

struct Card: Identifiable{
    var id = UUID().uuidString
    var cardId: String
    var image: Image
    var offset: CGFloat = 0
    var title: String
    var content: String
    var domesticAnnualFee: String = "국내전용 [10,000]원 "
    var requiredPreviousMonthUsage = 0
    var company: String
}
