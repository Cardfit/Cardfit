//
//  LaunchScreen.swift
//  Cardfit
//
//  Created by 서동운 on 7/6/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State var percent: CGFloat = 0
    @Binding var isLoaded: Bool
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    init(percent: CGFloat, isLoaded: Binding<Bool>) {
        self.percent = percent
        self._isLoaded = isLoaded
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color("AppColor")
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Image("Fit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
        }
        .onReceive(timer) { time in
            if percent == CGFloat(100) {
                timer.upstream.connect().cancel()
                isLoaded = true
            } else {
                percent += 20
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(percent: 0, isLoaded: .constant(false))
    }
}
