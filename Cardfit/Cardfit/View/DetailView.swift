//
//  DetailView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    @State private var Details = false
    
    var animation: Namespace.ID
    var body: some View {
        ZStack {
            VStack{
                
                Text(model.selectedCard.company)
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
            
                HStack{
                    Text(model.selectedCard.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, alignment: .leading)
                        .padding()
                        .matchedGeometryEffect(id: "Title-\(model.selectedCard.title)", in: animation)
                    
                    Spacer(minLength: 0)
                }
                
                
                
                if model.showContent{
                    ScrollView(showsIndicators: false){
                        model.selectedCard.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250, alignment: .center)
                        
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("연회비 : ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    
                                Text(model.selectedCard.domesticAnnualFee)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            HStack{
                                Text("기준실적 : ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                Text("\(model.selectedCard.requiredPreviousMonthUsage)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 350)
                        .padding()
                        
                        
                        VStack{
                            BenefitView(cate: "할인", benefit: "[FANDOM] 팬덤 10% 청구할인- 앱 결제: 구글플레이, 앱스토어 \n\n* 앱스토어: App Store, Apple Music, iCloud&nbsp; \n\n* 국내 Google Play, Apple Services에 등록하여 결제 시 혜택 적용&nbsp; \n\n* Google Play: 계정 - 국가 및 프로필 내 국가를 대한민국으로 설정 \n\n* Apple Services: App Store 계정 국가/지역을 대한민국으로 설정 \n\n* 해외 승인으로 거래 시 할인 적용 제외- 팬덤: 더 세임(the SameE), 위버스샵- 음반/서적: 교보문고, 교보핫트랙스, 영풍문고, 예스24, 알라딘- 스트리밍: 넷플릭스. 유튜브프리미엄, 멜론, 지니뮤직, 벅스 \n\n* 대상가맹점 공식 홈페이지(앱)을 통해 직접 신청한 이용 건에 한하여 할인 제공(구글플레이, 앱스터오, 1회성 일반 구매 결제, 앱마켓 결제 등 할인 혜택 제외)&nbsp; \n\n* 넷플릭스의 경우 Basic, Standard, Premium 요금제에 한하여 할인 적용- 티켓: 옥션티켓, 페이북공연- 공식 홈페이지/앱/가맹점 내 결제건에 한하며, 타사 또는 제휴사이트를 통한 결제건은 할인 제외됩니다.")
                                .padding([.leading,.trailing])
                            
                            
                            BenefitView(cate: "생활", benefit: "[LIFE] 생활 10% 청구할인- 게임: 넥슨캐시&nbsp; * 대상 가맹점: 넥슨캐시 온라인 충전금액(모바일 충전금액 제외)&nbsp; * 넥슨닷컴:(www.nexon.com) 내 넥슨 캐시 충전페이지를 통해 충전된 금액에 한하여 적용됩니다.&nbsp; * 모바일에서 충전하신 금액은 할인 대상에서 제외됩니다.- 이미용: 이용원, 미용원 업종- 대중교통: 버스, 지하철(후불교통)- 배달: 배달의 민족, 요기요, 쿠팡이츠&nbsp; * 공식 홈페이지/앱/가맹점 내 결제 건에 한하며, 타사 또는 제휴사이트를 통한 결제건 및 현장 결제의 경우 할인 제외됩니다.&nbsp; * 배달 서비스 이용 시 혜택 적용되며, 배달 앱 내 상품권 구매 및 배달 서비스 이용 시 혜택 적용 제외됩니다.")
                            .padding([.leading,.trailing])
                            
                            BenefitView(cate: "해피", benefit: "행복한 생각 행복한 생각 뷰를 어떻게 수정해도 이쁘지 않아. 내가 만든 티가 너무나네 행복한 생각 행복한 생각. 모든 제품 10% 할인 해주는 마법의 카드가 있었으면 좋겠다. 행복한 생각 행복한 생각 같은 cate는 묶어야 하는가? 같이 묶는게 좋겠지? 내 생각에도 그래")
                            .padding([.leading,.trailing])
                        }
//                        VStack{
//                            Text(model.selectedCard.content)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding()
//
//                            Text()
//                        }
                    }
                }
                
                Spacer(minLength: 0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                model.selectedColor
                    .cornerRadius(25)
                    .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                    .ignoresSafeArea(.all, edges: .bottom)
            )
            
            VStack{
                Spacer()
                
                if model.showContent{
                    Button(action: CloseView) {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                            .padding(5)
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.bottom)
                }
            }
        }

    }
    
    func CloseView(){
        
        withAnimation(.spring()){
            model.showCard.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.easeIn){
                    model.showContent = false
                }
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
