//
//  DotView.swift
//  Cardfit
//
//  Created by 서동운 on 7/22/23.
//

import SwiftUI

struct DotView: View {
    
    @State var delay: Double = 0
    @State var scale: CGFloat = 0.5
    
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .padding()
            .foregroundColor(Color("AppColor"))
            .scaleEffect(scale)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay))
            .onAppear {
                withAnimation {
                    self.scale = 1
                }
            }
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView()
    }
}
