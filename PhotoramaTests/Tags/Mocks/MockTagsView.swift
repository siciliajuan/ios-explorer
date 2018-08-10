//
//  MockTagsView.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 8/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class MockTagsView: TagsViewProtocol {
    
    var presenter: TagsPresenterProtocol!
    
    var photo: Photo!
    
    var showAddTagAlerCalled = false
    
    var tags: [String]!
    
    func setTags(_ tags: [String]) {
        self.tags = tags
    }
    
    func showAddTagAler() {
        showAddTagAlerCalled = true
    }
}
