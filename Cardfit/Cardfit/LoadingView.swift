//
//  LoadingView.swift
//  Cardfit
//
//  Created by 서동운 on 6/7/23.
//

import SwiftUI

struct LoadingView: View {
    
    @State var percent: CGFloat = 0
    private var isLoaded: Bool { percent == CGFloat(100) ? true : false }
    let selectedCards: [Card]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isLoaded ? "카드 등록이 완료되었습니다." : "카드 등록중입니다...")
                .font(.title2)
            
            LoadingProgressView(percent: $percent)
            
            Text(String(format: "%.0f", percent) + "%")
            
            Button(isLoaded ? "확인" : "취소") {
            }
            .fontWeight(.bold)
            .font(.system(size: 20))
            .foregroundColor(percent == CGFloat(100) ? .blue : .red)
            .buttonStyle(.plain)
            .padding(.top, 10)
        }
        .onAppear {
            if !selectedCards.isEmpty {
                Task(priority: .background) {
                    await saveToPersistence(cards: selectedCards)
                }
            }
        }
    }
    
    func saveToPersistence(cards: [Card]) async {
        let cardNumbers = cards.map { $0.cardNumber }
        let predicate = NSPredicate(format: "cardNumber IN %@", cardNumbers)
    
        do {
            PersistenceController.shared.deleteData(entity: .userCardEntity)
            let cardEntities = try PersistenceController.shared.fetchData(entity: .cardEntity, entityType: CardEntity.self, predicate: predicate)
            PersistenceController.shared.saveSingleData(entityType: UserCardEntity.self) { userCardEntity in
                cardEntities.forEach { entity in
                    userCardEntity.addToCards(entity)
                }
            }
        } catch {
            print(error)
        }

        for index in (1...100) {
            DispatchQueue.main.async {
                self.percent = CGFloat(index)
            }
            
            Thread.sleep(forTimeInterval: 0.005)
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
                    LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .trailing)
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
