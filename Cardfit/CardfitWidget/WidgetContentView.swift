//
//  WidgetContentView.swift
//  Cardfit
//
//  Created by 서동운 on 6/21/23.
//

import SwiftUI

struct WidgetContentView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                
                Spacer()
                Divider()
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    
                }
                .padding(15)
            }
        }
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView(card: Card())
    }
}
