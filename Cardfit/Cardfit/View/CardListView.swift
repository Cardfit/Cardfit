//
//  CardListView.swift
//  Cardfit
//
//  Created by 서동운 on 6/2/23.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject private var viewModel: CardListViewModel
    
    @State private var isLoading = true
    
    init(company: CompanyList) {
        self.viewModel = CardListViewModel(company: company)
    }
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else {
                ForEach(viewModel.cardList, id: \.self) { card in
                    CardListViewCell(isSelected: bindingForCard(card), card: card, company: viewModel.company)
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            Task(priority: .background) {
                let result = await viewModel.fetchCardList()
                switch result {
                case .success(let cards):
                    viewModel.cardList = cards
                    isLoading = false
                case .failure(let error):
                    print(error)
                }
            
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.selectedCards.isEmpty {
                    NavigationLink(destination: LoadingView(selectedCards: viewModel.selectedCards).navigationBarBackButtonHidden()) {
                        Text("추가")
                            .foregroundColor(Color("AppColor"))
                    }
                } else {
                    Text("추가")
                        .foregroundColor(.gray)
                }
            }
        }
        .onDisappear {
            viewModel.selectedCards = []
        }
    }
    
    private func bindingForCard(_ card: Card) -> Binding<Bool> {
        Binding<Bool> (
            get: {
                viewModel.selectedCards.contains(card)
            },
            set: { newValue in
                if newValue {
                    viewModel.selectedCards.append(card)
                } else {
                    viewModel.selectedCards.removeAll(where: { $0 == card })
                }
            }
        )
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .bc)
        }
    }
}

