//
//  main.swift
//  Photorama
//
//  Created by juan sicilia on 23/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum AppReset {
    static func resetCoreData() {
        let coreDataStack = CoreDataStack()
        let tagsFetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        let photosFetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoMO")
        resetCoreDataByRequest(coreDataStack, tagsFetchRequest)
        resetCoreDataByRequest(coreDataStack, photosFetchRequest)
    }
    
    static func resetCoreDataByRequest(_ coreDataStack : CoreDataStack, _ fetchRequest :NSFetchRequest<NSFetchRequestResult>) {
        let context = coreDataStack.getNewManagedObjectContext()!
        let objs = try! context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            context.delete(obj)
        }
        coreDataStack.saveChanges(context: context)
    }
}

_ = autoreleasepool {
    
    if ProcessInfo().arguments.contains("--Reset") {
        AppReset.resetCoreData()
    }
    
    UIApplicationMain( CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, NSStringFromClass(AppDelegate.self)
    )
}
