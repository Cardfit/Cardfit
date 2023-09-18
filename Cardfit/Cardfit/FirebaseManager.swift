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
                        print(error, #function)
                        continuation.resume(returning: Data())
                    }
                }
            }
        }
    }
    
    func fetchCardInfo(of company: CompanyList, after cardNumber: String?, size: Int = 10) async throws -> [Card] {
        let reference = getQuery(of: company, startAfter: cardNumber)
        let fixedNumberOfCard = reference.limit(to: size)
        let snapshots = try await fixedNumberOfCard.getDocuments().documents
        
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
    
    func getTotalCountOfCard(of company: CompanyList) async -> Int {
        do {
            let reference = getQuery(of: company, startAfter: nil)
            let snapshots = try await reference.getDocuments().documents
            let numberOfCards = snapshots.count
            return numberOfCards
        } catch {
            print("Failed to get total count")
            return 0
        }
    }

    private func createCard(from snapshot: QueryDocumentSnapshot, company: CompanyList) async throws -> Card {
        var card = try snapshot.data(as: Card.self)
        card.company = company.rawValue
        
        let imageData = await downloadImageData(company: company, cardNumber: card.cardNumber)
        card.imageData = imageData
        
        return card
    }
    
}

extension FirebaseManager {
    private func getQuery(of company: CompanyList, startAfter cardNumber: String?) -> Query {
        let cardListRef = firestore.collection("CardList")
        let allCardInfo = cardListRef.document("CardInfo")
        var query = allCardInfo.collection(company.rawValue).order(by: "cardNumber", descending: true)
        if let lastCardNumber = cardNumber {
            query = query.start(at: [lastCardNumber])
        }
        
        return query
    }
}
