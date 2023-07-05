//
//  Persistence.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import CoreData

struct PersistenceController {
    enum Entity: String {
        case cardEntity = "CardEntity"
        case userCardEntity = "UserCardEntity"
    }
    
    private let appGroup = "group.Hud.Cardfit"
    static let shared = PersistenceController(inMemory: false)
    let container = NSPersistentContainer(name: "Cardfit")
    
    private init(inMemory: Bool = true) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)?.appendingPathComponent("Card.sqlite")
            container.persistentStoreDescriptions.first!.url = storeURL
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveSingleData<Entity: NSManagedObject>(entityType: Entity.Type, completion: (Entity) -> Void) {
        let viewContext = container.viewContext
        let newEntity = Entity(context: viewContext)
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("엔티티 생성 후 저장 실패: \(error), \(error.userInfo)")
        }
        
        completion(newEntity)
        
        do {
            try viewContext.save()
            print("단일 데이터 저장 완료")
        } catch let error as NSError {
            print("단일 데이터 저장 실패: \(error), \(error.userInfo)")
        }
    }
    
    func saveMulitpleData<Model: Codable, Entity: NSManagedObject>(datas: [Model], entityType: Entity.Type, completion: (Model, Entity) -> Void) {
        let viewContext = container.viewContext
        
        datas.forEach { data in
            let newEntity = Entity(context: viewContext)
            
            completion(data, newEntity)
        }
        
        do {
            try viewContext.save()
            print("다수의 데이터 저장 완료")
        } catch let error as NSError {
            print("다수의 데이터 저장 실패: \(error), \(error.userInfo)")
        }
    }
    
    /// 엔티티 데이터를 가져옴. 엔티티타입을 Return하기 때문에 예제 코드처럼 모델로 매핑해서 사용해야함.
    ///
    ///     let entities = try PersistenceController.shared
    ///                        .fetchData(entity: .cardEntity,
    ///                                   entityType: CardEntity.self,
    ///                                   predicate: NSPredicate(format: "company == %@",
    ///                                   company.rawValue))
    ///
    ///     let cards = try entities.map { cardEntity in
    ///         let benefit = try JSONDecoder().decode(Benefits.self, from: cardEntity.benefit ?? Data())
    ///         let card = Card(id: Int(cardEntity.cardNumber!), cardName: cardEntity.cardName, cardNumber: cardEntity.cardNumber ?? String(), cardImageURL: cardEntity.cardImageURL, domesticAnnualFee: cardEntity.domesticAnnualFee, requiredPreviousMonthUsage: cardEntity.requiredPreviousMonthUsage, mainBenefit: cardEntity.mainBenefit, company: cardEntity.company, benefit: benefit)
    ///     return card
    ///     }
    ///
    /// - Parameter entity: Enum으로 선언한 Entity 타입  (ex: .cardEntity)
    /// - Parameter entityType: 엔티티의 실직적인 타입 (ex: CardEntity.self)
    /// - Returns: [NSFetchRequestResult]

    func fetchData<Result: NSFetchRequestResult>(entity: Entity, entityType: Result.Type, predicate: NSPredicate? = nil) -> [Result] {
        let viewContext = container.viewContext
        let fetchRequest = NSFetchRequest<Result>(entityName: entity.rawValue)
        
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try viewContext.fetch(fetchRequest)
            return fetchResult
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
    
    func deleteData(entity: Entity) {
        let viewContext = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            print("데이터 삭제 완료")
        } catch let error as NSError {
            print("데이터 삭제 실패: \(error), \(error.userInfo)")
        }
    }
}
