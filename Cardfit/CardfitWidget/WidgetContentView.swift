//
//  WidgetContentView.swift
//  Cardfit
//
//  Created by 서동운 on 6/21/23.
//

import SwiftUI
import WidgetKit

struct WidgetContentView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                TitleLabel(title: card.cardName ?? String(), font: .title2)
                    .padding([.top, .leading, .bottom], 15)
               
                .padding([.leading, .trailing], 15)
                .padding(.bottom, 5)
                
                BenefitList(benefit: card.benefit ?? Benefits())
                Spacer()
                Divider()
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    TitleLabel(title: "브랜드", font: .title3)
                    LogoHStack(brands: [])
                }
                .padding(15)
            }
            
            CardImageView(name: "CardImage")
        }
    }
}
                
struct BenefitList: View {
    @State var benefit: Benefits
    
    var body: some View {
        ForEach(benefit, id: \.self) { benefit in
            BenefitCell(title: "\(benefit.keys.first): \(benefit.values)")
        }
    }
}

struct BenefitCell: View {
    let title: String
    
    var body: some View {
        Button(title) {
            
        }
        .buttonStyle(.plain)
        .font(.subheadline)
        .fontWeight(.semibold)
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.1))
        }
    }
}

struct LogoHStack: View {
    @State var brands: [String]
    
    var body: some View {
        HStack(spacing: -5) {
            ForEach(0..<10) { index in
                //Image(brand[index])
                
                Circle()
                    .foregroundColor(Color.randomColor())
                    .frame(width: 35, height: 35)
            }
        }
    }
}

extension Color {
    static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView(card: Card())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
