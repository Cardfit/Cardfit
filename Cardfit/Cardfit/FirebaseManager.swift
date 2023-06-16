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
    
    func downloadImage(company: CompanyList, cardNumber: String) async -> UIImage? {
        await withCheckedContinuation { continuation in
            storage.reference(forURL: "gs://cardfit-b9d71.appspot.com/CardImage/\(company.rawValue)/\(cardNumber)").downloadURL { url, error in
                DispatchQueue.global().async {
                    do {
                        guard let url = url else {
                            print("downloadImage(), 잘못된 URL")
                            continuation.resume(returning: nil)
                            return
                        }
                        let data = try Data(contentsOf: url)
                        guard let uiImage = UIImage(data: data) else {
                            print("downloadImage(), data 없음")
                            continuation.resume(returning: nil)
                            return
                        }
                        continuation.resume(returning: uiImage)
                    } catch {
                        print(error)
                        continuation.resume(returning: nil)
                    }
                }
            }
        }
    }
    
    func fetchCardInfo(of company: CompanyList) async throws -> [Card] {
        let reference = getReference(of: company)
        let snapshots = try await reference.getDocuments().documents
        let cards = try snapshots.map { snapshot in
            var card = try snapshot.data(as: Card.self)
            
            card.company = company.rawValue
            
            return card
        }
        return cards
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
