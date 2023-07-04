//
//  LoadingView.swift
//  Cardfit
//
//  Created by 서동운 on 6/7/23.
//

import SwiftUI
import Combine

struct LoadingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var percent: CGFloat = 0
    @State private var rotationAngle: Double = 0
    
    private var isSaved: Bool { percent == CGFloat(100) ? true : false }
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    let selectedCards: [Card]
    
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
            
            LoadingProgressView(percent: $percent)
            
            Text(String(format: "%.0f", percent) + "%")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("AppColor"))
            
            Button(isSaved ? "확인" : "취소") {
                if isSaved {
                    NavigationManager.shared.popToRoot()
                } else {
                    //                    PersistenceController.shared.deleteData(entity: .userCardEntity)
                    dismiss()
                }
            }
            .fontWeight(.bold)
            .font(.system(size: 20))
            .foregroundColor(percent == CGFloat(100) ? Color("AppColor") : .red)
            .buttonStyle(.plain)
            .padding(.top, 50)
        }
        .onAppear {
            if !selectedCards.isEmpty {
                Task(priority: .background) {
                    await saveToPersistence(cards: selectedCards)
                }
            }
        }
        .onReceive(timer) { time in
            if percent == CGFloat(100) {
                timer.upstream.connect().cancel()
            } else {
                percent += 1
            }
        }
    }
    
    func saveToPersistence(cards: [Card]) async {
        let cardNumbers = cards.map { $0.cardNumber }
        let predicate = NSPredicate(format: "cardNumber IN %@", cardNumbers)
        
        // ✅ 일단 기존에 등록한 카드를 모두 삭제후 재등록하도록 구현
        PersistenceController.shared.deleteData(entity: .userCardEntity)
        
        let cardEntities = PersistenceController.shared.fetchData(entity: .cardEntity, entityType: CardEntity.self, predicate: predicate)
        PersistenceController.shared.saveSingleData(entityType: UserCardEntity.self) { userCardEntity in
            cardEntities.forEach { entity in
                userCardEntity.addToCards(entity)
            }
        }
    }
}

struct LoadingProgressView: View {
    
    @Binding var percent: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.black.opacity(0.1))
                .frame(width: 300, height: 20)
            
            Capsule()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.white, Color("AppColor")]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 300 * percent/100, height: 20)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(selectedCards: [])
    }
}
