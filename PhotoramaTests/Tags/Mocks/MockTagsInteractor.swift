//
//  MockTagsInteractor.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 8/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class MockTagsInteractor: TagsInteractorInputProtocol {
    
    var presenter: TagsInteractorOutputProtocol!
    
    var store: (PhotosRepositoryProtocol & TagsRepositoryProtocol)!
    
    var photo: Photo!
    var tags = [String]()
    
    var retrieveTagsIsBeenCalled = false
    
    func retrieveTags() {
        retrieveTagsIsBeenCalled = true
        tags = TestHelpers.createRandomTags(amount: 15)
        presenter.didRetrievedTags(tags)
    }
    
    func save(tag: String) {
        tags.append(tag)
    }
    
    func update(photo: Photo) {
        self.photo = photo
    }
}
