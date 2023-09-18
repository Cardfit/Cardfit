//
//  JSONCoder.swift
//  Cardfit
//
//  Created by 서동운 on 9/17/23.
//

import Foundation

class JSONCoder {
    static let shared = JSONCoder()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func decode<T: Decodable>(type: T.Type, from: Data) -> T? {
        do {
            return try decoder.decode(type, from: from)
        } catch {
            print(error)
            return nil
        }
    }
    
    func encode<T: Encodable>(value: T) -> Data {
        do {
            return try encoder.encode(value)
        } catch {
            print(error)
            return Data()
        }
    }
}


