//
//  MockTagsPresenter.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 8/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class MockTagsPresenter: TagsPresenterProtocol, TagsInteractorOutputProtocol {
    
    var view: TagsViewProtocol!
    var route: TagsWireFrameProtocol!
    var interactor: TagsInteractorInputProtocol!
    
    // for test purpose
    var tags: [String]!
    
    func viewDidLoad() {
        
    }
    
    func didDoneTags(forPhoto photo: Photo) {
        
    }
    
    func didAddTag() {
        
    }
    
    func didSave(tag: String) {
        
    }
    
    func didRetrievedTags(_ tags: [String]) {
        self.tags = tags
    }
}
