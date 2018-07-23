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
    
    func save(tag: String) {
        tagsCoreData.saveTag(tag)
    }
    
    func getTags(byNameList names: [String]) -> [NSManagedObject]? {
        return tagsCoreData.getTags(byNameList: names)
    }
}
