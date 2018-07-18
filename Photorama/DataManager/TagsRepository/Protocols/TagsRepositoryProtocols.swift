//
//  TagsRepositoryProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

protocol TagsRepositoryProtocol {
    func getTagsSortedByName() throws -> [NSManagedObject]
    func saveTag(_ tagName: String)
}
