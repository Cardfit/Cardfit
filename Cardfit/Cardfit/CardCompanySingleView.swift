//
//  CardCompanySingleView.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import SwiftUI

struct CardCompanySingleView: View {
    
    var imageURL: String
    var name: String
    var mainBenefit: String
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: imageURL), scale: 1)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .background(.white)
                .padding(.all, 20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text(mainBenefit)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.gray)
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct CardCompanySingleView_Previews: PreviewProvider {
    static var previews: some View {
        CardCompanySingleView(imageURL: "", name: "국민카드", mainBenefit: "메인혜택")
    }
}
