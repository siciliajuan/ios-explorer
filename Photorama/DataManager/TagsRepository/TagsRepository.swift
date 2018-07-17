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
    
    var tagsCoreData: TagsDataProtocol
    
    init() {
        tagsCoreData = TagsCoreData()
    }
    
    func retrieveTagsBySortDescriptor(_ sortDescriptors: [NSSortDescriptor]? = nil) throws -> [NSManagedObject] {
        return try tagsCoreData.retrieveTagsBySortDescriptor(sortDescriptors)
    }
    
}
