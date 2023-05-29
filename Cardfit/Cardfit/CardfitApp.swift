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
    
    // todo(domb): 다른 파일로 분리하기
    let companies = ["KB", "HD", "..."]
    
    init() {
        // 앱 실행시 초기 설정 여기서
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { newValue in
            print(newValue)
        }
    }
}
