//
//  FirebaseManager.swift
//  Cardfit
//
//  Created by 서동운 on 5/29/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import CoreData
import UIKit

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
    
    func downloadImageData(company: CompanyList, cardNumber: String) async -> Data {
        await withCheckedContinuation { continuation in
            storage.reference(forURL: "gs://cardfit-b9d71.appspot.com/CardImage/\(company.rawValue)/\(cardNumber)").downloadURL { url, error in
                DispatchQueue.global().async {
                    do {
                        guard let url = url else {
                            print("downloadImage(), 잘못된 URL")
                            continuation.resume(returning: Data())
                            return
                        }
                        let data = try Data(contentsOf: url)
                        continuation.resume(returning: data)
                    } catch {
                        print(error)
                        continuation.resume(returning: Data())
                    }
                }
            }
        }
    }
    
    func fetchCardInfo(of company: CompanyList) async throws -> [Card] {
        let reference = getReference(of: company)
        let snapshots = try await reference.getDocuments().documents
        
        var cards: [Card] = []
        for snapshot in snapshots {
            do {
                let card = try await createCard(from: snapshot, company: company)
                cards.append(card)
            } catch {
                print("Error creating card:", error)
            }
        }
        
        return cards
    }

    func createCard(from snapshot: QueryDocumentSnapshot, company: CompanyList) async throws -> Card {
        var card = try snapshot.data(as: Card.self)
        card.company = company.rawValue
        
        if let cardNumber = card.cardNumber {
            let imageData = await downloadImageData(company: company, cardNumber: cardNumber)
            card.imageData = imageData
        }
        
        return card
    }

}

extension FirebaseManager {
    private func getReference(of company: CompanyList) -> CollectionReference {
        let cardListRef = firestore.collection("CardList")
        let allCardInfo = cardListRef.document("CardInfo")
        let selectedCompanyReference = allCardInfo.collection(company.rawValue)
        
        return selectedCompanyReference
    }
}
