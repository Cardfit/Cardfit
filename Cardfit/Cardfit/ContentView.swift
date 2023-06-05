//
//  ContentView.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CardEntity.cardNumber, ascending: true)])
    private var cards: FetchedResults<CardEntity>

    var body: some View {
        Text("Content View Body")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
