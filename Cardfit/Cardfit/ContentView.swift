//
//  ContentView.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var mainModel = CarouselViewModel()
    var body: some View {
        Main()
            .environmentObject(mainModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
