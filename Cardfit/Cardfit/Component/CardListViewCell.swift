//
//  CardListViewCell.swift
//  Cardfit
//
//  Created by 서동운 on 6/1/23.
//

import SwiftUI

struct CardListViewCell: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: CardListViewModel
    @Binding var isSelected: Bool
    @State private var image: UIImage?
    
    let card: Card
    let company: CompanyList
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .background(.white)
                    .padding(.all, 20)
            } else {
                ProgressView()
                    .frame(width: 80)
                    .padding(20)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(card.cardName ?? String())
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 25)
                
                Text(card.mainBenefit ?? String())
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            Spacer(minLength: 10)
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(isSelected ? .blue : .gray)
                .padding([.top, .trailing], 20)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : .black.opacity(0.3), lineWidth: 1)
        )
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .onTapGesture {
            isSelected.toggle()
        }
        .onAppear {
            downLoadImage()
        }
    }
    
    func downLoadImage() {
        Task(priority: .background) {
            let image = await FirebaseManager.shared.downloadImage(company: company, cardNumber: card.cardNumber ?? "")
            self.image = image
        }
    }
}

struct CardListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CardListViewCell(isSelected: .constant(false), card: .init(cardNumber: ""), company: .bc)
    }
}
