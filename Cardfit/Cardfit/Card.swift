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
    case samgsung = "SAMGSUNG"
    case sh = "SH"
    case sc = "SC"
    case shinhan = "SHINHAN"
    case ssgpay = "SSGPAY"
    case theHyundai = "THE HYUNDAI"
    case woori = "WOORI"
    
    // 카드별 이미지 데이터 UIImage?
    var image: String {
        return "image"
    }
    
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
            return "크레딧유니언카드"
        case .dgb:
            return "DGB카드"
        case .gwangju:
            return "광주카드"
        case .hana:
            return "하나카드"
        case .hyundai:
            return "현대카드"
        case .ibk:
            return "IBK기업카드"
        case .jbBank:
            return "JB은행카드"
        case .jeju:
            return "제주은행카드"
        case .kb:
            return "국민카드"
        case .kBank:
            return "케이뱅크카드"
        case .lotte:
            return "롯데카드"
        case .nh:
            return "농협카드"
        case .samgsung:
            return "삼성카드"
        case .sh:
            return "신한카드"
        case .sc:
            return "스탠다드차타드카드"
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



struct Card: Codable {
    
    var cardName: String?
    var cardNumber: String?
    var cardImageURL: String?
    var domesticAnnualFee: String?
    var requiredPreviousMonthUsage: Int?
    var mainBenefit: String?
}

