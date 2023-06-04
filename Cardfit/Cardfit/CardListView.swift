//
//  CardListView.swift
//  Cardfit
//
//  Created by 서동운 on 6/2/23.
//

import SwiftUI

struct CardListView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CardEntity.cardNumber, ascending: true)])
    private var cards: FetchedResults<CardEntity>
    private let company: CompanyList
    
    init(company: CompanyList) {
        self.company = company
    }
    
    var body: some View {
        ScrollView {
            ForEach(cards, id: \.self) { card in
                CardCompanySingleView(imageURL: card.cardImageURL ?? String(), name: card.cardName ?? String(), mainBenefit: card.mainBenefit ?? String())
            }
        }
        .onAppear {
            Task(priority: .background) {
                let viewContext = PersistenceController.shared.container.viewContext
                await FirebaseManager.shared.fetchCardInfo(of: company, in: viewContext)
            }
        }
//        .modifier(CustomNavigationBar(title: "\(categoryViewModel.category.icon) \(categoryViewModel.category.rawValue.capitalized)"))
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView(company: .bc)
        }
    }
}

