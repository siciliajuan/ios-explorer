//
//  CoreDataStack.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let managedObjectModelName: String
    
    
    required init(modelName: String) {
        managedObjectModelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: managedObjectModelName)
        container.loadPersistentStores(completionHandler: {
            storeDescription, error in
            if let error = error {
                fatalError("Could load data store: \(error)")
            }
        })
        return container
    }()
    
    lazy var managedObjectMainContext: NSManagedObjectContext =
        self.persistentContainer.viewContext
    
    func getNewManagedObjectContext() -> NSManagedObjectContext {
        return self.persistentContainer.newBackgroundContext()
    }
    
    func saveChanges(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let saveError {
            print("Core Data save failed: \(saveError)")
        }
    }
}
