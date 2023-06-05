//
//  CardListView.swift
//  Cardfit
//
//  Created by 서동운 on 6/2/23.
//

import SwiftUI

struct CardListView: View {
    
    @State private var isLoading = false
    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CardEntity.cardNumber, ascending: true)])
//    private var cards: FetchedResults<CardEntity>
    @State private var cards: [Card] = []
    @State private var selectedCards: [Card] = []
    @State private var showDetail = false
    private let company: CompanyList
    
    init(company: CompanyList) {
        self.company = company
    }
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            }
            ForEach(cards, id: \.self) { card in
                CardCompanySingleView(isSelected: selectedCards.contains(card), imageURL: card.cardImageURL ?? String(), name: card.cardName ?? String(), mainBenefit: card.mainBenefit ?? String())
            }
        }
        .onAppear {
            isLoading = true
            Task(priority: .background) {
                let cardList = await FirebaseManager.shared.fetchCardInfo(of: company)
                self.cards = cardList
                isLoading = false
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    selectedCards = cards.filter { card in
//                        card.isSelected
//                    }
//                    showDetail = true
//                }) {
//                    Text("추가")
//                }
//            }
//        }
//        .sheet(isPresented: $showDetail) {
//            DetailView(selectedCards: $selectedCards)
//        }
//        .modifier(CustomNavigationBar(title: "\(categoryViewModel.category.icon) \(categoryViewModel.category.rawValue.capitalized)"))
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .chai)
        }
    }
}

