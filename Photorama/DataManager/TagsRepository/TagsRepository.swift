//
//  TagsRepository.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

class TagsRepository: TagsRepositoryProtocol {
    
    var tagsCoreData: TagsCoreData
    
    init(coreDataStack: CoreDataStack) {
        tagsCoreData = TagsCoreData(coreDataStack: coreDataStack)
    }
    
    func getTagsSortedByName() throws -> [String] {
        return try tagsCoreData.getTagsSortedByName()
    }
    
    func saveTag(_ tagName: String) {
        tagsCoreData.saveTag(tagName)
    }
    
    func getTagsByNameList(names: [String]) -> [NSManagedObject]? {
        return tagsCoreData.getTagsByNameList(names: names)
    }
}
