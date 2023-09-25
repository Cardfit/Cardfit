//
//  BenefitView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/06/02.
//

import SwiftUI

struct BenefitView: View {
    @State private var details = false
    var category: String
    var benefit: String
    
    var body: some View {
        DisclosureGroup(isExpanded: $details, content: {
            Text(benefitInputEnter(benefit))
                .padding(.top)
                .foregroundColor(Color(uiColor: .label))
        },
        label: {
            Image(category).renderingMode(.template)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(uiColor: .label))
                .aspectRatio(contentMode: .fill)
            
            Text(Category.match(category))
        })
        .padding()
        .foregroundColor(.init(uiColor: .label))
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(uiColor: .systemBackground))
        }
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(uiColor: .label), lineWidth: 2))
    }
    
    func benefitInputEnter(_ benefit: String) -> String{
        benefit.replacingOccurrences(of: "*", with: "\n\n*").replacingOccurrences(of: "※", with: "\n\n※").replacingOccurrences(of: "-", with: "\n -")
    }
}

struct BenefitView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitView(category: "1", benefit: "")
    }
}
