//
//  CardfitApp.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import SwiftUI
import FirebaseFirestoreSwift

@main
struct CardfitApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    init() {
        // 앱 실행시 초기 설정 여기서
    }

    var body: some Scene {
        WindowGroup {
            CardSearchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { newValue in
            print(newValue)
        }
    }
}
