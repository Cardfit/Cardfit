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
    var category: [String] {
        return card.benefit?.flatMap({ $0.keys }) ?? []
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                TitleLabel(title: card.cardName, font: .title3, color: .white)
                    .padding(.leading, 10)
                    .frame(height: 70)
                Spacer()
                CardImageView(imageData: card.imageData ?? Data())
                    .padding(10)
            }
            .background(Color("AppColor"))
            BenefitList(benefit: card.benefit ?? Benefits())
            Spacer()
            Divider()
                .padding(.horizontal, 10)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading) {
                TitleLabel(title: "브랜드", font: .headline, color: Color("AppColor"))
                    .padding(5)
                    .padding(.bottom, 0)
                LogoHStack(category: category)
            }
            .padding(10)
        }
        .foregroundColor(.white)
    }
}


struct BenefitList: View {
    @State var benefit: Benefits
    
    var body: some View {
        ForEach(benefit.prefix(3), id: \.self) { benefit in
            BenefitCell(benefit: benefit.values.first!)
        }
        .padding([.top, .leading, .bottom], 5)
    }
}

struct BenefitCell: View {
    let benefit: [String: String]
    
    @State private var isExpanded = false
    
    var body: some View {
        LazyVStack {
            HStack(alignment: .firstTextBaseline) {
                Text(benefit["category"] ?? String())
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .padding(5)
                    .foregroundColor(Color("AppColor"))
                    .background {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(.background)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color("AppColor"), lineWidth: 1)
                    )
                Text(benefitInputEnter(benefit["description"] ?? String()))
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary.opacity(0.8))
                    .lineLimit(2)
                Spacer()
            }
        }
    }
    
    func benefitInputEnter(_ benefit: String) -> String {
        benefit.replacingOccurrences(of: "*", with: "\n\n*").replacingOccurrences(of: "※", with: "\n\n※").replacingOccurrences(of: "-", with: "\n -")
    }
}

struct LogoHStack: View {
    @State var category: [String]
    
    var body: some View {
        HStack {
            if category.count > 0 {
                ForEach(category.prefix(6), id: \.self) { index in
                    Image(index)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(6)
                        .foregroundColor(.primary)
                        .background {
                            Circle().fill(.background)
                        }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView(card: .placeholder())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
