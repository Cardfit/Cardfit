//
//  CompanyButton.swift
//  Cardfit
//
//  Created by 서동운 on 6/2/23.
//

import SwiftUI

struct CompanyButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let company: CompanyList
    
    var body: some View {
        ZStack {
            VStack {
                Image(company.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width / 6)
                    .padding(.all, 5)
                Spacer()
                Text(company.kor)
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top, 5)
            }
            .padding(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
        }
    }
}

struct CompanyButton_Previews: PreviewProvider {
    static var previews: some View {
        CompanyButton(company: .bc)
    }
}
