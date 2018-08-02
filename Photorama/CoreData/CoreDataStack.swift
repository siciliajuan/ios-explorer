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
    
    static var managedObjectMainContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }
    
    static func getNewManagedObjectContext() -> NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }
    
    static func saveChanges(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let saveError {
            print("Core Data save failed: \(saveError)")
        }
    }
}
