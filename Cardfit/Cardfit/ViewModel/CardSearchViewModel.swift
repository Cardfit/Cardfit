//
//  CardSearchViewModel.swift
//  Cardfit
//
//  Created by 서동운 on 6/5/23.
//

import Foundation
import Combine

class CardSearchViewModel: ObservableObject {
    @Published var searchText = String()
    @Published var filteredCompanyList: [CompanyList] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterCompanies(searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterCompanies(_ searchText: String) {
        filteredCompanyList = CompanyList.allCases.filter { $0.kor.contains(searchText) || $0.rawValue.contains(searchText) || $0.rawValue.contains(searchText.uppercased())
        }
    }
}
