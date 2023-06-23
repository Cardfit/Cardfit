//
//  CardImageView.swift
//  CardfitWidgetExtension
//
//  Created by 서동운 on 6/21/23.
//

import SwiftUI
import WidgetKit

struct CardImageView: View {
    let imageData: Data
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.gray.opacity(0.1))
                .frame(width: 50)
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
        }
        .padding(10)
    }
}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageView(imageData: Data()).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
