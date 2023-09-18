//
//  Repository.swift
//  Cardfit
//
//  Created by 서동운 on 9/17/23.
//

import Foundation
import RealmSwift

final class Repository {
    private var realm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Hub.Cardfit")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 0)
        return try! Realm(configuration: config)
    }
    
    static let shared = Repository()
    
    private init() { }
    
    // MARK: Get
    
    func fetchUserCards() async -> [Card] {
        let result = realm.objects(UserCardEntity.self).flatMap { $0.cards.map { $0.toDomain() } }
        return Array(result)
    }
    
    func fetchUserCards() -> [Card] {
        let result = realm.objects(UserCardEntity.self).flatMap { $0.cards.map { $0.toDomain() } }
        return Array(result)
    }
    
    func fetchCards() -> [Card]{
        let result = realm.objects(CardEntity.self).map { $0.toDomain() }
        return Array(result)
    }
    
    func fetchFilteredCards(isIncluded: (CardEntity) -> Bool) -> [Card] {
        let result = realm.objects(CardEntity.self).filter(isIncluded).sorted(by: { $0.cardNumber < $1.cardNumber }).map { $0.toDomain() }
        return Array(result)
    }
    
    // MARK: Save
    
    func saveUserCards(_ userCards: [Card]) {
        do {
            try realm.write {
                let userCardEntity = UserCardEntity()
                userCardEntity.cards.append(objectsIn: userCards.map { $0.toEntity() })
                realm.add(userCardEntity)
            }
        } catch {
            print(error)
        }
    }
    
    func saveCards(_ cards: [Card]) {
        do {
            try realm.write {
                realm.add(cards.map { $0.toEntity() })
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Delete
    
    func deleteAll() {
       do {
            try realm.write {
                realm.deleteAll() 
            }
            
        } catch {
            print(error)
        }
    }
    
    func deleteUserCards() {
        let result = realm.objects(UserCardEntity.self)
        
        do {
            try realm.write {
                realm.delete(result)
            }
            
        } catch {
            print(error)
        }
    }
    
    func deleteCards() {
        let result = realm.objects(CardEntity.self)
        do {
            try realm.write {
                realm.delete(result)
            }
            
        } catch {
            print(error)
        }
    }
    
    func deleteFilteredCards(isIncluded: (CardEntity) -> Bool) {
        let result = realm.objects(CardEntity.self).filter(isIncluded)
        do {
            try realm.write {
                realm.delete(result)
            }
            
        } catch {
            print(error)
        }
    }
}


