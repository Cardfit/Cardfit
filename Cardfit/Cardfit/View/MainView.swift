//
//  Home.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

var width = UIScreen.main.bounds.width

struct Main: View {
    @EnvironmentObject var model: MainViewModel
    @Namespace var animation
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    HStack(alignment: .center){
                        Text("My Cards")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.leading, 25)
                        Spacer()
                        
                        Button {
                            isPresented = true
                        } label: {
                            Image(systemName: "plus.app")
                                .resizable()
                                .foregroundColor(Color("AppColor"))
                                .frame(width: 40, height: 40)
                        }
                        .padding(.trailing, 20)
                        .navigationDestination(isPresented: $isPresented) {
                            CardSearchView()
                        }
                    }
                    .onReceive(NavigationManager.shared.isActivePublisher) { isPresented in
                        self.isPresented = isPresented
                    }
                    
                    if !model.cards.isEmpty {
                        ZStack{
                            
                            ForEach(model.cards.indices.reversed(), id:\.self){index in
                                HStack{
                                    CardView(card: model.cards[index], color: getColor(index: index), animation: animation, image: model.image[index])
                                        .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                        .offset(x: getCardOffset(index: index))
                                        .rotationEffect(.init(degrees: getCardRotation(index: index)))
                                    Spacer(minLength: 0)
                                }
                                .frame(height: 400)
                                .contentShape(Rectangle())
                                .offset(x: model.cards[index].offset ?? 0)
                                .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ (value) in
                                        onChanged(value: value, index: index)
                                    })
                                        .onEnded({ (value) in
                                            onEnd(value: value, index: index)
                                        })
                                )
                                
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal, 30)
                        Button(action: ResetViews) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .padding(.top, 35)
                    } else {
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: "plus.app")
                                .foregroundColor(Color("AppColor"))
                            Text("를 눌러서 카드를 등록해주세요.")
                        }
                        .font(.system(size: 23))
                        .padding(.top, 30)
                    }
                    Spacer()
                }
                
                // Detail View
                if model.showCard {
                    DetailView(animation: animation)
                }
            }
            .onAppear {
                Task {
                    let result = await model.fetchUserCardList()
                    switch result {
                    case .success(let cards):
                        print(cards)
                        self.model.cards = cards
                        for i in model.cards{
                            if let imageData = i.imageData, let uiImage = UIImage(data: imageData) {
                                model.image.append(Image(uiImage: uiImage))
                            }
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
        .accentColor(Color("AppColor"))
    }
    
    func ResetViews(){
        for index in model.cards.indices{
            withAnimation {
                model.cards[index].offset = 0
                model.swipedCard = 0
            }
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int){
        if value .translation.width < 0{
            model.cards[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int){
        withAnimation{
            if -value.translation.width > width / 3{
                model.cards[index].offset = -width
                model.swipedCard += 1
            }
            else {
                model.cards[index].offset = 0
            }
            if index == model.cards.count - 1{
                ResetViews()
            }
        }
    }
    
    func getCardRotation(index: Int) -> Double{
        let boxWidth = Double(width / 3)
        let offset = Double(model.cards[index].offset ?? 0)
        let angle: Double = 8
        
        return (offset / boxWidth) * angle
    }
    
    // Getting Width And Height For Card ....
    func getCardHeight(index: Int) -> CGFloat{
        let height : CGFloat = 400
        let cardHeight = index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int) -> CGFloat{
        let boxWidth = UIScreen.main.bounds.width - 60 - 60
        
        return boxWidth
    }
    
    // Getting Offset...
    func getCardOffset(index: Int) -> CGFloat{
        return index - model.swipedCard  <= 2 ? CGFloat(index - model.swipedCard) * 30 : 60
    }
    
    func getColor(index: Int) -> Color{
        let colorList = [Color("LightBlue"), Color("LightOrange"), Color("LightPink"), Color("LightPurple"), Color("LightYellow")]
        return colorList[index % colorList.count]
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main().environmentObject(MainViewModel())
    }
}
