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
    
    lazy var privateQueueContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = self.mainQueueContext
        moc.name = "Primary Private Queue Context"
        return moc
    }()
    
    private var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first! as NSURL
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.ManagedObjectModel)
        let pathComponent = "\(self.managedObjectModelName).sqlite"
        let url = self.applicationDocumentsDirectory.appendingPathComponent(pathComponent)
        print("core data is in: \(String(describing: url))")
        let store = try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        return coordinator
    }()
    
    lazy var mainQueueContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        moc.name = "Main Queue Context (UI Context)"
        return moc
    }()
    
    required init(modelName: String) {
        managedObjectModelName = modelName
    }
    
    private lazy var ManagedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.managedObjectModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    func saveChanges() throws {
        var error: Error?
        
        privateQueueContext.performAndWait {
            if self.privateQueueContext.hasChanges {
                do {
                    try self.privateQueueContext.save()
                } catch let saveError {
                    error = saveError
                }
            }
        }
        
        if let error = error {
            throw error
        }
        
        mainQueueContext.performAndWait() {
            if self.mainQueueContext.hasChanges {
                do {
                    try self.mainQueueContext.save()
                } catch let saveError {
                    error = saveError
                }
            }
        }
        if let error = error {
            throw error
        }
    }
    
}
