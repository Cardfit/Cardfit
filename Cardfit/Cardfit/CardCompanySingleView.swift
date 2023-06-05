//
//  CardCompanySingleView.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import SwiftUI

struct CardCompanySingleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var isSelected = false
    
    var imageURL: String
    var name: String
    var mainBenefit: String
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: imageURL))
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .background(.white)
                .padding(.all, 20)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 22)
                    
                Text(mainBenefit)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            .padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
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
