//
//  Persistence.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = true) {
        container = NSPersistentContainer(name: "Cardfit")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Card.sqlite")
            container.persistentStoreDescriptions.first!.url = storeURL
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
