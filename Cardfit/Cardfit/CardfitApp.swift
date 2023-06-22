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
    @StateObject var mainModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(mainModel)
        }.onChange(of: scenePhase) { newValue in
            // 영구저장소에 잘못 저장된데이터가 있으면 여기서 지우세요!
//            if newValue == .inactive {
//                PersistenceController.shared.deleteData(entity: .cardEntity)
//            }
        }
    }
}
