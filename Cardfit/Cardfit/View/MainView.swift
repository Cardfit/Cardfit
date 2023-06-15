//
//  Home.swift
//  CardViewStudy
//
//  Created by 김경호 on 2023/05/31.
//

import SwiftUI

var width = UIScreen.main.bounds.width

struct Main: View {
    @EnvironmentObject var model: CarouselViewModel
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Spacer()
                    
                    HStack{
                        Text("My Cards")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.leading, 25)
                        Spacer()
                        
                        NavigationLink{
                            CardSearchView()
                        } label: {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding()
//                        Button {
////                            NavigationLink{
////                                CardSearchView()
////                            }
////                            .navigationTitle("메인화면")
//                        } label: {
//                            Image(systemName: "plus.app")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//                        .padding()


                    }
                    
                    // Carousel
                    ZStack{
                        ForEach(model.cards.indices.reversed(), id:\.self){index in
                            HStack{
                                CardView(card: model.cards[index], color: getColor(index: index), animation: animation)
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
                    
                    Spacer()
                }
                
                // Detail View
                if model.showCard{
                    DetailView(animation: animation)
                }
            }
        }
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
        ContentView()
    }
}
