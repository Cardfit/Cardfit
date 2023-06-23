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
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                TitleLabel(title: card.cardName ?? String(), font: .title3)
                    .padding([.top, .leading, .bottom], 15)
                    .frame(height: 70, alignment: .bottom)
                Divider()
                    .padding(.horizontal, 10)
                BenefitList(benefit: card.benefit ?? Benefits())
                    .padding(.leading, 10)
                Spacer()
                Divider()
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    TitleLabel(title: "브랜드", font: .headline)
                    LogoHStack(category: category)
                        .padding(.leading, 5)
                }
                .padding(15)
            }
            
            CardImageView(imageData: card.imageData ?? Data())
        }
    }
}
                
struct BenefitList: View {
    @State var benefit: Benefits
    
    var body: some View {
        ForEach(benefit, id: \.self) { benefit in
            BenefitCell(benefit: benefit.values.first!)
        }
        .padding([.top, .leading, .trailing], 5)
        .padding(.bottom, 5)
    }
}

struct BenefitCell: View {
    let benefit: [String: String]
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(benefit["category"] ?? String())
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.1))
                    }
                Text(benefit["description"] ?? String())
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(4)
            }
        }
    }
}

struct LogoHStack: View {
    @State var category: [String]
    
    var body: some View {
        HStack() {
            if category.count > 0 {
                ForEach(category, id: \.count) { index in
                    //Image(brand[index])
                    Image(index)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding(6)
                        .background {
                            Circle().fill(.gray.opacity(0.2))
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
