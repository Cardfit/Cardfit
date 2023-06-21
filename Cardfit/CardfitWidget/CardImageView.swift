//
//  CardImageView.swift
//  CardfitWidgetExtension
//
//  Created by 서동운 on 6/21/23.
//

import SwiftUI
import WidgetKit

struct CardImageView: View {
    let name: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.gray.opacity(0.1))
                .frame(width: 70)
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
        }
        .padding(10)
    }
}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageView(name: "CardImage").previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
