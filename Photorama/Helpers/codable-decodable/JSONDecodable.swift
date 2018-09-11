//
//  JSONDecodable.swift
//  Photorama
//
//  Created by juan sicilia on 10/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

func decode<T:Codable>(_ data: Data) -> T? {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch let error {
        print("Error decoding, error: \(error)")
        return nil
    }
}
