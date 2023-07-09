//
//  CardView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var model: MainViewModel
    
    @State var card: Card
    var color: Color
    var animation: Namespace.ID
    var image: Image
    
    var body: some View {
        VStack{
            Text(card.cardName ?? "")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.85))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, 10)
                .matchedGeometryEffect(id: "Name-\(card.cardName)", in: animation)
            
            HStack{
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding()
//                if let imageData = card.imageData, let uiImage = UIImage(data: imageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 250, height: 250, alignment: .center)
//                        .padding()
//                } else {
//                    ProgressView()
//                        .frame(width: 250, height: 250, alignment: .center)
//                        .padding()// 이미지 로딩 중일 때 표시될 로딩 표시기
//                }

                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
            HStack{
                Spacer(minLength: 0)
                
                if !model.showContent{
                    Text("Read More")
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.white.opacity(0.9))
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            color
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.secondary, lineWidth: 2))
            .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()){
                model.selectedCard = card
                model.selectedColor = color
                model.showCard.toggle()
                print("Detail True : ", model.showCard)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    withAnimation(.easeIn){
                        model.showContent = true
                    }
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
