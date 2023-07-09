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
                .fill(.white)
                .frame(width: 40)
            Image(uiImage: UIImage(data: imageData)?.preparingThumbnail(of: CGSize(width: 100, height: 100)) ?? UIImage(named: "CardImage")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
        }
    }
}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageView(imageData: Data())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
