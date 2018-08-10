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
    
    var presenter: TagsInteractorOutputProtocol!
    
    var store: (PhotosRepositoryProtocol & TagsRepositoryProtocol)!
    
    func retrieveTags() {
        presenter.didRetrievedTags(try! store.getTagsSortedByName())
    }
    
    func save(tag: String) {
        store.save(tag: tag)
        retrieveTags()
    }
    
    func update(photo: Photo) {
        store.update(photo: photo)
    }
}
