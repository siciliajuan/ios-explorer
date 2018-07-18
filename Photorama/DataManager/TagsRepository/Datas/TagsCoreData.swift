//
//  TagsCoreData.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

class TagsCoreData: TagsDataProtocol {
    
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func retrieveTagsBySortDescriptor() throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.predicate = nil
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueueTags: [NSManagedObject]?
        var fetchRequestError: Error?
        mainQueueContext.performAndWait() {
            do {
                mainQueueTags = try mainQueueContext.fetch(fetchRequest) as? [NSManagedObject]
            } catch let error {
                fetchRequestError = error
            }
        }
        guard let tags = mainQueueTags else {
            throw fetchRequestError!
        }
        return tags
    }
    
    func saveTag(_ tagName: String) {
        let context = coreDataStack.mainQueueContext
        let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
        newTag.setValue(tagName, forKey: "name")
    }
}
