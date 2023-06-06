//
//  CardView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var model: CarouselViewModel
    var card: Card
    var color: Color
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            Text(card.title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.85))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, 10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
        
            HStack{
//                Text(card.title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .frame(width: 250, alignment: .leading)
//                    .padding()
//                    .matchedGeometryEffect(id: "Title-\(card.id)", in: animation)
                card.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding()
//                    .matchedGeometryEffect(id: "Image-\(card.id)", in: animation)
                
                
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
//            card.cardColor
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
        ContentView()
    }
}
