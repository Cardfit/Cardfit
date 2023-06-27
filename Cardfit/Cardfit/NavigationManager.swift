//
//  NavigationManager.swift
//  Cardfit
//
//  Created by 서동운 on 6/27/23.
//

import Foundation
import Combine

class NavigationManager {
    
    static let shared = NavigationManager()
    let isActivePublisher = PassthroughSubject<Bool, Never>()

    private init() {}
    
    func popToRoot() {
        isActivePublisher.send(false)
    }
}
