//
//  BenefitView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/06/02.
//

import SwiftUI

struct BenefitView: View {
    @State private var Details = false
    var cate: String
    var benefit: String
    
    var body: some View {
        DisclosureGroup(isExpanded: $Details, content: {
            Text(benefitInputEnter(benefit))
                .padding(.top)
        },
        label: {
            Image(cate)
                .resizable()
                .frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fill)
            
            Text(cateMatching(cate))
        }
        )
        .padding()
        .foregroundColor(.black)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        }//.padding([.leading,.trailing])
        .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 2))
    }
    
    func benefitInputEnter(_ benefit: String) -> String{
        benefit.replacingOccurrences(of: "*", with: "\n\n*").replacingOccurrences(of: "※", with: "\n\n※").replacingOccurrences(of: "-", with: "\n -")
    }
    
    func cateMatching(_ cate: String) -> String{
        switch cate{
        case "1":
            return "간편결제"
        case "2":
            return "공과금/렌탈"
        case "3":
            return "공항라운지/PP"
        case "4":
            return "교육/육아"
        case "5":
            return "교통"
        case "6":
            return "금융"
        case "7":
            return "기타"
        case "8":
            return "레저/스포츠"
        case "9":
            return "마트/편의점"
        case "10":
            return "멤버십포인트"
        case "11":
            return "모든가맹점"
        case "12":
            return "무실적"
        case "13":
            return "병원/약국"
        case "14":
            return "뷰티/피트니스"
        case "15":
            return "비즈니스"
        case "16":
            return "쇼핑"
        case "17":
            return "애완동물"
        case "18":
            return "여행/숙박"
        case "19":
            return "영화/문화"
        case "20":
            return "자동차/하이패스"
        case "21":
            return "주유"
        case "22":
            return "카페/디저트"
        case "23":
            return "통신"
        case "24":
            return "푸드"
        case "25":
            return "프리미엄"
        case "26":
            return "항공마일리지"
        case "27":
            return "해외"
        case "28":
            return "유의사항"
        case "29":
            return "네이버페이"
        case "31":
            return "카카오페이"
        case "33":
            return "APP"
        case "35":
            return "공과금"
        case "36":
            return "렌탈"
        case "38":
            return "PP"
        case "39":
            return "공항라운지"
        case "40":
            return "라운지키"
        case "42":
            return "국민행복"
        case "45":
            return "어린이집"
        case "48":
            return "학원"
        case "49":
            return "기타"
        case "51":
            return "기타"
        case "52":
            return "대중교통"
        case "53":
            return "택시"
        case "55":
            return "보험사"
        case "56":
            return "은행사"
        case "59":
            return "기타"
        case "63":
            return "하이브리드"
        case "64":
            return "지역"
        case "65":
            return "무이자할부"
        case "66":
            return "카드사"
        case "67":
            return "연회비지원"
        case "68":
            return "선택형"
        case "69":
            return "경기관람"
        case "70":
            return "골프"
        case "71":
            return "테마파크"
        case "72":
            return "게임"
        case "74":
            return "SSM"
        case "75":
            return "대형마트"
        case "77":
            return "편의점"
        case "79":
            return "BC TOP"
        case "82":
            return "해피포인트"
        case "83":
            return "캐시백"
        case "84":
            return "기타"
        case "85":
            return "할인"
        case "86":
            return "적립"
        case "87":
            return "병원"
        case "90":
            return "드럭스토어"
        case "92":
            return "헤어"
        case "93":
            return "화장품"
        case "96":
            return "면세점"
        case "97":
            return "백화점"
        case "98":
            return "아울렛"
        case "99":
            return "온라인쇼핑"
        case "100":
            return "홈쇼핑"
        case "101":
            return "소셜커머스"
        case "107":
            return "렌터카"
        case "110":
            return "호텔"
        case "111":
            return "기타"
        case "112":
            return "공연/전시"
        case "115":
            return "영화"
        case "117":
            return "보험"
        case "118":
            return "정비"
        case "120":
            return "하이패스"
        case "122":
            return "주유소"
        case "125":
            return "베이커리"
        case "127":
            return "카페"
        case "129":
            return "KT"
        case "130":
            return "LG"
        case "131":
            return "SKT"
        case "133":
            return "일반음식점"
        case "135":
            return "패밀리레스토랑"
        case "136":
            return "아침"
        case "137":
            return "점심"
        case "138":
            return "저녁"
        case "139":
            return "배달앱"
        case "141":
            return "대한항공"
        case "142":
            return "아시아나항공"
        case "143":
            return "제주항공"
        case "148":
            return "기타"
        case "149":
            return "수수료우대"
        case "150":
            return "해외이용"
        case "154":
            return "생활"
        case "157":
            return "프리미엄 서비스"
        case "158":
            return "바우처"
        case "159":
            return "항공권"
        case "160":
            return "공항"
        case "164":
            return "렌터카"
        case "165":
            return "자동차"
        case "166":
            return "저가항공"
        case "167":
            return "온라인 여행사"
        case "168":
            return "제휴/PLCC"
        case "169":
            return "디지털구독"
        case "180":
            return "국내외가맹점"

        
        default:
            return ""
        }
    }
}

struct BenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
