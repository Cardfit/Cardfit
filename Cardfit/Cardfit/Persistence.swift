//
//  Persistence.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController(inMemory: false)
    let container = NSPersistentContainer(name: "Cardfit")

    private init(inMemory: Bool = true) {
        
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
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchCardEntities(for company: CompanyList) throws -> [CardEntity] {
        
        let viewContext = container.viewContext
        let fetchRequest: NSFetchRequest<CardEntity> = CardEntity.fetchRequest()
        let predicate = NSPredicate(format: "company == %@", company.rawValue)
        
        fetchRequest.predicate = predicate
        
        return try viewContext.fetch(fetchRequest)
    }
    
    func changeToCardEntity(from card: [Card]) {
        
        let viewContext = container.viewContext
        
        card.forEach { card in
            
//            if let existingCardCompany = fetchCardCompany(with: card.company, in: viewContext) {
//
//            } else {
//                let cardCompanyType = CardCompanyEntity(context: viewContext)
//                cardCompanyType.name = card.company
//            }
            
            let cardEntity = CardEntity(context: viewContext)
            
            cardEntity.cardName = card.cardName
            cardEntity.cardImageURL = card.cardImageURL
            cardEntity.cardNumber = card.cardNumber
            cardEntity.mainBenefit = card.mainBenefit
            cardEntity.company = card.company
        }
    }
    
    func resetCardEntity() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CardEntity")

        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try container.viewContext.execute(deleteRequest)
            
        } catch {
            print("Failed to delete data in 'Card.sqlite': \(error)")
        }
    }
    
//    func fetchCardCompany(with name: String, in context: NSManagedObjectContext) -> CardCompanyEntity? {
//
//        let fetchRequest: NSFetchRequest<CardCompanyEntity> = CardCompanyEntity.fetchRequest()
//
//        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            return result.first
//        } catch {
//            print("Error fetching CardCompanyEntity: \(error)")
//            return nil
//        }
//    }
}
