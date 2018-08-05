//
//  TagsCoreData.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

class TagsCoreData {
    
    var coreDataStack: CoreDataStack!
    
    func getTagsSortedByName() throws -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.predicate = nil
        let mainQueueContext = coreDataStack.getNewManagedObjectContext()!
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
        return tags.map{$0.value(forKey: "name") as! String}
    }
    
    func saveTag(_ tagName: String) {
        let context = coreDataStack.getNewManagedObjectContext()!
        let newTag = NSEntityDescription.insertNewObject(forEntityName: "TagMO", into: context)
        newTag.setValue(tagName, forKey: "name")
        coreDataStack.saveChanges(context: context)
    }
}
