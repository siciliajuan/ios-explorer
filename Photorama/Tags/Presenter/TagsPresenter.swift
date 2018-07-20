//
//  TagsPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsPresenter: TagsPresenterProtocol {
    
    var view: TagsViewProtocol?
    var route: TagsWireFrameProtocol?
    var interactor: TagsInteractorInputProtocol?
    
    func viewDidLoad() {
        interactor?.retrieveTags()
    }
    
    func dismissTags() {
        route?.dismissTags(from: view!)
    }
    
    func updateTags() {
        interactor?.retrieveTags()
    }
    
    func saveTag(_ tagName: String) {
        interactor?.saveTag(tagName)
    }
    
    func commitPersistentData(photo: PhotoTO) {
        interactor?.updatePhoto(photo: photo)
    }
}

extension TagsPresenter: TagsInteractorOutputProtocol {
    
    func didRetrievedTags(_ tags: [String]) {
        view?.setTags(tags)
    }
    
}
