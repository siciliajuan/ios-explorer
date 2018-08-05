//
//  TagsPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class TagsPresenter {
    
    var view: TagsViewProtocol!
    var route: TagsWireFrameProtocol!
    var interactor: TagsInteractorInputProtocol!
}

extension TagsPresenter: TagsPresenterProtocol {
    
    func photoDidSet() {
        interactor.retrieveTags()
    }
    
    func didDoneTags(forPhoto photo: Photo) {
        interactor.update(photo: photo)
        route.dismissTagsVC(from: view!)
    }
    
    func didAddTag() {
        view.showAddTagAler()
    }
    
    func didSave(tag: String) {
        interactor.save(tag: tag)
    }
}

extension TagsPresenter: TagsInteractorOutputProtocol {
    
    func didRetrievedTags(_ tags: [String]) {
        view.setTags(tags)
    }
    
}
