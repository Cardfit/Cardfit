//
//  LoadingView.swift
//  Cardfit
//
//  Created by 서동운 on 6/7/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        @State var percent: CGFloat = 50
        
        VStack(spacing: 20) {
            Text("카드 등록중입니다.")
                .font(.title2)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: 300, height: 20)
                
                Capsule()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.accentColor, .red]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: 300 * percent/100, height: 20)
            }
            
            Text(String(format: "%.0f", percent) + "%")
                .padding(.trailing, 10)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
