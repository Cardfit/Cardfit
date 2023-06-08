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
    
    func downloadImage(company: CompanyList, cardNumber: String) async -> UIImage? {
        
        await withCheckedContinuation { continuation in
            storage.reference(forURL: "gs://cardfit-b9d71.appspot.com/CardImage/\(company.rawValue)/\(cardNumber)").downloadURL { url, error in
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    let uiImage = UIImage(data: data!)
                    
                    continuation.resume(returning: uiImage)
                }
            }
        }
    }
    
    func getReference(of company: CompanyList) -> CollectionReference {
        let cardListRef = firestore.collection("CardList")
        let allCardInfo = cardListRef.document("CardInfo")
        let selectedCompanyReference = allCardInfo.collection(company.rawValue)

        return selectedCompanyReference
    }

    func fetchCardNumberList(of company: CompanyList) async -> [String] {
        var cardNumberList: [String] = []
        
        do {
            let reference = getReference(of: company)
            let snapshots = try await reference.getDocumentsSnapShot()
            snapshots.forEach { snapshot in
                cardNumberList.append(snapshot.documentID)
            }
        } catch {
            print(error)
        }
        
        return cardNumberList
    }

    func fetchCardInfo(of company: CompanyList) async throws -> [Card] {
        
        let reference = getReference(of: company)
        let snapshots = try await reference.getDocumentsSnapShot()
        var cards = try snapshots.getData(as: Card.self)
        
        cards = cards.map { card in
            var updatedCard = card
            updatedCard.company = company.rawValue
            return updatedCard
        }
        
        return cards
    }
}

extension CollectionReference {
    
    func getDocumentsSnapShot() async throws -> [QueryDocumentSnapshot] {
        do {
            let cardsOfSelectedCompany = try await self.getDocuments().documents
            return cardsOfSelectedCompany
        }
    }
}

extension [QueryDocumentSnapshot] {
    func getData<T: Decodable>(as type: T.Type) throws -> [T] {
        
        var decodedData: [T] = []
        
        do {
            try self.forEach { snapshot in
                let data = try snapshot.data(as: type)
                decodedData.append(data)
            }
        }
        
        return decodedData
    }
}

