//
//  CoreDataStack.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    lazy var persistentContainer: NSPersistentContainer = preparePersistentContainer()
    
    func preparePersistentContainer() -> NSPersistentContainer{
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("Could load data store: \(error)")
            }
        })
        return container
    }
    
    func getNewManagedObjectContext() -> NSManagedObjectContext? {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    func saveChanges(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let saveError {
            print("Core Data save failed: \(saveError)")
        }
    }
    
    func clearAllData() {
        let names = persistentContainer.managedObjectModel.entities.map({ (entity) -> String in
            return entity.name!
        })
        for name in names {
            clearCoreDataEntity(byEntityName: name)
        }
    }
    
    private func clearCoreDataEntity(byEntityName entity: String) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let context = getNewManagedObjectContext()!
        let objs = try! context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            context.delete(obj)
        }
        saveChanges(context: context)
    }
}
