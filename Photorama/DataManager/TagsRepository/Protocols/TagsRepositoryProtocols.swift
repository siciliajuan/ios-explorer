//
//  TagsRepositoryProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

protocol TagsRepositoryProtocol {
    func getTagsSortedByName() throws -> [String]
    func saveTag(_ tagName: String)
}
