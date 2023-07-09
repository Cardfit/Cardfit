//
//  DetailView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var model: MainViewModel
    
    var animation: Namespace.ID
    var body: some View {
        ZStack {
            VStack{
                
                Text(model.selectedCard.company ?? "")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "Name-\(model.selectedCard.cardName)", in: animation)
            
                HStack{
                    Text(model.selectedCard.cardName ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, alignment: .leading)
                        .padding()
                        .matchedGeometryEffect(id: "Title-\(model.selectedCard.cardName)", in: animation)
                    
                    Spacer(minLength: 0)
                }
                
                
                
                if model.showContent{
                    ScrollView(showsIndicators: false){
                        if let imageData = model.selectedCard.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250, alignment: .center)
                            
                        } else {
                            Image("CardImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250, alignment: .center)
                                .padding()// 이미지 로딩 중일 때 표시될 로딩 표시기
                        }
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("연회비 : ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    
                                Text(model.selectedCard.domesticAnnualFee ?? "0")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            HStack{
                                Text("기준실적 : ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                Text("\(model.selectedCard.requiredPreviousMonthUsage ?? 0)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 350)
                        .padding()
                        
                        // Benefit
                        VStack{
                            ForEach(model.selectedCard.benefit ?? [], id:\.self) { data in
                                BenefitView(category: data.first?.key ?? "28", benefit: data.values.first?["description"] ?? "")
                                    .padding([.leading, .trailing])
                            }
                        }
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
                    Button(action: closeView) {
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
    
    func closeView(){
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
        Main()
    }
}
