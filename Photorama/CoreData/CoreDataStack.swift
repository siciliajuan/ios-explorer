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
    
    lazy var managedObjectContext: NSManagedObjectContext =
        self.persistentContainer.newBackgroundContext()
    
    func saveChanges() throws {
        do {
            try managedObjectContext.save()
        } catch let saveError {
            throw saveError
        }
    }
}
