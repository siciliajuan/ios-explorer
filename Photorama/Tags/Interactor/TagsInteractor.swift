//
//  TagsInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

class TagsInteractor: TagsInteractorInputProtocol {
    
    var presenter: TagsInteractorOutputProtocol?
    
    var store: PhotoStore!
    
    func retrieveTags() {
        presenter?.didRetrievedTags(try! store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]))
    }
    
    func saveChanges() {
        do {
            try store.coreDataStack.saveChanges()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
    }
}
