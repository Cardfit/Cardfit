//
//  FirebaseManager.swift
//  Cardfit
//
//  Created by 서동운 on 5/29/23.
//

import Foundation
import Firebase
import FirebaseStorage
import CoreData

class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
    
    let storage: Storage
    let firestore: Firestore
    
    override init() {
        FirebaseApp.configure()
        
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    func fetchCardInfo(of company: CompanyList) async -> [Card] {
        var cardList: [Card] = []
        
        let cardListRef = firestore.collection("CardList")
        let allCardInfo = cardListRef.document("CardInfo")
        let cardsOfSelectedCompany = allCardInfo.collection(company.rawValue)
        
        do {
            let cardNumberRefs = try await cardsOfSelectedCompany.getDocuments().documents
            
            for cardNumberRef in cardNumberRefs {
                do {
                    let cardSnapshot = try await cardsOfSelectedCompany.document(cardNumberRef.documentID).getDocument()
                    let card = try cardSnapshot.data(as: Card.self)
                    cardList.append(card)
                    
                } catch {
                    print("Failed to fetch card info:", error)
                }
            }
        } catch {
            print("Failed to fetch card number refs:", error)
        }
        
        return cardList
    }
}

