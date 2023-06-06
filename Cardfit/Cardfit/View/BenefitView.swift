//
//  BenefitView.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/06/02.
//

import SwiftUI

struct BenefitView: View {
    @State private var Details = false
    var cate: String
    var benefit: String
    
    var body: some View {
        DisclosureGroup(cate, isExpanded: $Details) {
            Text(benefit)
                .padding(.top)
        }
        .padding()
        .foregroundColor(.black)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        }//.padding([.leading,.trailing])
        .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 2))
    }
}

struct BenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
