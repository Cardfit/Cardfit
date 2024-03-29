//
//  LoadingView.swift
//  Cardfit
//
//  Created by 서동운 on 6/7/23.
//

import SwiftUI
import Combine

struct CardRegisterView: View {
    
    @ObservedObject var viewModel: CardRegisterViewModel
    
    @State var percent: CGFloat = 0
    @State private var rotationAngle: Double = 0
    private var isSaved: Bool { percent == CGFloat(100) ? true : false }
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    init(viewModel: CardRegisterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image("CardImage")
                .resizable()
                .frame(width: 150, height: 100)
                .rotation3DEffect(.degrees(rotationAngle), axis: (0,1,0))
                .onAppear {
                    withAnimation(Animation.linear(duration: 5)) {
                        rotationAngle += 360
                    }
                }
                .onReceive(Just(isSaved)) { isSaved in
                }
                .padding(100)
            Text(isSaved ? "카드 등록 완료" : "카드 등록중...")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color("AppColor"))
            
            LoadingProgressView(percent: $percent, startColor: Color(uiColor: .systemBackground), endColor: Color("AppColor"))
            
            Text(String(format: "%.0f", percent) + "%")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("AppColor"))
            
            Button("확인") {
                NavigationManager.shared.popToRoot()
            }
            .disabled(!isSaved)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .foregroundColor(Color("AppColor"))
            .buttonStyle(.plain)
            .padding(.top, 50)
        }
        .onAppear {
            viewModel.saveCards()
        
        }
        .onReceive(timer) { time in
            if percent == CGFloat(100) {
                timer.upstream.connect().cancel()
            } else {
                percent += 1
            }
        }
    }
}

struct LoadingProgressView: View {
    
    @Binding var percent: CGFloat
    var startColor: Color
    var endColor: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.black.opacity(0.1))
                .frame(width: 300, height: 20)
            
            Capsule()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 300 * percent/100, height: 20)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CardRegisterView(viewModel: CardRegisterViewModel(selectedCards: []))
    }
}
