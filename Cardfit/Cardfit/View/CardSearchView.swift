//
//  CardSearchView.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import SwiftUI
import Combine

struct CardSearchView: View {
    @StateObject private var viewModel = CardSearchViewModel()
    
    private var columnGrid = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnGrid) {
                ForEach(viewModel.searchText.isEmpty ? CompanyList.allCases : viewModel.filteredCompanyList, id: \.rawValue) { company in
                    NavigationLink {
                        CardListView(company: company)
                    } label: {
                        CompanyButton(company: company)
                    }
                    
                }
            }
            .padding([.top, .horizontal])
            .padding(.bottom, 80)
        }
        .navigationTitle("카드 선택")
        .accentColor(.black)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "카드사 검색")
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
}

struct CardSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CardSearchView()
    }
}
