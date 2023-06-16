//
//  Card.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import Foundation

enum CompanyList: String, CaseIterable {
    case bc = "BC CARD"
    case chai = "CHAI"
    case bnk = "BNK"
    case citi = "CITI"
    case creditUnion = "CREDIT UNION"
    case dgb = "DGB"
    case gwangju = "GWANGJU"
    case hana = "HANACARD"
    case hyundai = "HYUNDAI CARD"
    case ibk = "IBK"
    case jbBank = "JBBANK"
    case jeju = "JEJU-BANK"
    case kb = "KB"
    case kBank = "KBANK"
    case lotte = "LOTTE"
    case nh = "NHCARD"
    case samsung = "SAMSUNG"
    case sh = "SH"
    case sc = "SC"
    case shinhan = "SHINHAN"
    case ssgpay = "SSGPAY"
    case theHyundai = "THE HYUNDAI"
    case woori = "WOORI"
    
    var kor: String {
        switch self {
        case .bc:
            return "비씨카드"
        case .chai:
            return "차이카드"
        case .bnk:
            return "BNK카드"
        case .citi:
            return "씨티카드"
        case .creditUnion:
            return "신협카드"
        case .dgb:
            return "DGB카드"
        case .gwangju:
            return "광주카드"
        case .hana:
            return "하나카드"
        case .hyundai:
            return "현대카드"
        case .ibk:
            return "IBK기업"
        case .jbBank:
            return "전북은행"
        case .jeju:
            return "제주은행"
        case .kb:
            return "국민카드"
        case .kBank:
            return "케이뱅크"
        case .lotte:
            return "롯데카드"
        case .nh:
            return "농협카드"
        case .samsung:
            return "삼성카드"
        case .sh:
            return "수협은행"
        case .sc:
            return "SC제일"
        case .shinhan:
            return "신한카드"
        case .ssgpay:
            return "SSG페이"
        case .theHyundai:
            return "더현대카드"
        case .woori:
            return "우리카드"
        }
    }
}

struct Card: Identifiable, Hashable, Codable {
    var id: Int?
    var cardName: String?
    var cardNumber: String?
    var cardImageURL: String?
    var domesticAnnualFee: String?
    var requiredPreviousMonthUsage: Int64?
    var mainBenefit: String?
    var company: String?
//    var benefit: [[String:String]]?
    var offset: CGFloat? = 0
}
