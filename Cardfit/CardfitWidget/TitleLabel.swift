//
//  TitleLabel.swift
//  CardfitWidgetExtension
//
//  Created by 서동운 on 6/21/23.
//

import SwiftUI
import WidgetKit

struct TitleLabel: View {
    @State var title: String
    @State var font: Font
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(font)
                .bold()
                .padding(5)
            Spacer()
        }
    }
}

struct TitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        TitleLabel(title: "타이틀", font: .body).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
