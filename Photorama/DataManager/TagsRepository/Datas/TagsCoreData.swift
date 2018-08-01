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
    
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func getTags(byNameList names: [String]) -> [NSManagedObject]? {
        let predicate = NSPredicate(format: "name IN %@", names)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        fetchRequest.sortDescriptors = nil
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.managedObjectMainContext
        var mainQueueTags: [NSManagedObject]?
        mainQueueContext.performAndWait() {
            do {
                mainQueueTags = try mainQueueContext.fetch(fetchRequest) as? [NSManagedObject]
            } catch let error {
                print("Error getting tags by names: \(names), gets error: \(error)")
            }
        }
        guard let tags = mainQueueTags else {
            print("Error trying to retrieve tags by names: \(names) on coreData; not found")
            return nil
        }
        return tags
    }
    
    func getTagsSortedByName() throws -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.predicate = nil
        let mainQueueContext = self.coreDataStack.managedObjectMainContext
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
        let context = coreDataStack.managedObjectMainContext
        let newTag = NSEntityDescription.insertNewObject(forEntityName: "TagMO", into: context)
        newTag.setValue(tagName, forKey: "name")
        coreDataStack.saveChanges(context: context)
    }
}
