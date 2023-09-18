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
    @State private var everyCardIsLoaded = false
    
    init(company: CompanyList) {
        self.viewModel = CardListViewModel(company: company)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.cardList, id: \.self) { card in
                    CardListViewCell(isSelected: bindingForCard(card), card: card, company: viewModel.company)
                        .environmentObject(viewModel)
                }
                if everyCardIsLoaded {
                    Text("카드 더이상 없음.")
                } else {
                    if !isLoading {
                        Button {
                            Task {
                                isLoading = true
                                await loadCardList()
                            }
                        } label: {
                            if !isLoading {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }.disabled(isLoading)
                    } else {
                        HStack {
                            DotView()
                            DotView(delay: 0.2)
                            DotView(delay: 0.4)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.selectedCards.isEmpty {
                    NavigationLink(destination: CardRegisterView(viewModel: CardRegisterViewModel(selectedCards: viewModel.selectedCards))
                        .navigationBarBackButtonHidden()) {
                        Text("추가")
                            .foregroundColor(Color("AppColor"))
                    }
                } else {
                    Text("추가")
                        .foregroundColor(.gray)
                }
            }
        }
        .task {
            await viewModel.getCardCountOnServer()
            await loadCardList()
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
    
    private func loadCardList() async {
        isLoading = true
        await viewModel.fetchCardList (onSuccess: {
            isLoading = false
        }, complete: {
            everyCardIsLoaded = true
        })
    }
}
struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .bc)
        }
    }
}

