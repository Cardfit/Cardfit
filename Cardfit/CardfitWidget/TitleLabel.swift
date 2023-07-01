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
    @State var color: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(font)
                .foregroundColor(color)
                .bold()
            Spacer()
        }
    }
}

struct TitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        TitleLabel(title: "타이틀", font: .body, color: .black).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
