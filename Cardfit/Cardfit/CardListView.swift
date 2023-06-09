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
                    CardListViewCell(company: viewModel.company, imageURL: card.cardImageURL ?? String(), cardNumber: card.cardNumber ?? String(), name: card.cardName ?? String(), mainBenefit: card.mainBenefit ?? String())
                }
                // domb: 이미지 로딩후 isLoading을 false로 바꾸는 로직 구현하기.
            }
        }
        .onAppear {
            Task {
                let result = await viewModel.fetchCardList()
                switch result {
                case .success(let entity):
                    viewModel.cardList = entity
                    isLoading = false
                case .failure(let error):
                    print(error)
                }
            
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: LoadingView()) {
                    Text("확인")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .bc)
        }
    }
}

