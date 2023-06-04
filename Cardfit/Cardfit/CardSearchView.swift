//
//  CardSearchView.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import SwiftUI
import Combine


class ViewModel: ObservableObject {
    
    @Published var search: String = ""
    @Published var selectedCardName: String = ""

    var filterdCompany: [CompanyList] {
        print(self)
        return filter(text: search)
    }
    
    func filter(text: String) -> [CompanyList] {
        let companies = CompanyList.allCases
        let filterdCompany = companies.filter { $0.kor.contains(text) }
        return filterdCompany
    }
}

struct CardSearchView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    private var columnGrid = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columnGrid) {
                    if viewModel.search.isEmpty {
                        ForEach(CompanyList.allCases, id: \.rawValue) { company in
                            NavigationLink {
                                CardListView(company: company)
                            } label: {
                                CompanyButton(company: company)
                            }
                        }
                    } else {
                        ForEach(viewModel.filterdCompany, id: \.rawValue) { company in
                            NavigationLink {
                                CardListView(company: company)
                            } label: {
                                CompanyButton(company: company)
                            }
                        }
                    }
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 80)
            }
            .modifier(CustomNavigationBar(title: "카드 선택"))
        }
        .searchable(text: $viewModel.search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for Card")
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        
    }
}

import SwiftUI

struct CustomNavigationBar: ViewModifier {
    
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .background(.white, ignoresSafeAreaEdges: .all)
            .safeAreaInset(edge: .top) {
                Color.clear
                    .frame(height: 0)
                    .background(.bar)
                    .border(.black)
            }
    }
}

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Capsule().fill(Color.blue))
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct CardSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CardSearchView()
    }
}
