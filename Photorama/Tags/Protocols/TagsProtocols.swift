//
//  TagsProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit


// presenter -> view
protocol TagsViewProtocol {
    var presenter: TagsPresenterProtocol? { get set }
    
    var photo: Photo! { get set }
    
    func setTags(_ tags: [String])
}

// view -> presenter
protocol TagsPresenterProtocol {
    var view: TagsViewProtocol? { get set }
    var route: TagsWireFrameProtocol? { get set }
    var interactor: TagsInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func didDoneTags(forPhoto photo: Photo)
    func didSave(tag: String)
}

// presenter -> router
// other route -> route
protocol TagsWireFrameProtocol {
    static func createTagsModuleVC(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
    func dismissTagsVC(from: TagsViewProtocol)
}

// presenter -> interactor
protocol TagsInteractorInputProtocol {
    var presenter: TagsInteractorOutputProtocol? { get set }
    
    var store: PhotoStore! { get set }
    
    func retrieveTags()
    func save(tag: String)
    func update(photo: Photo)
}


// interactor -> presenter
protocol TagsInteractorOutputProtocol {
    func didRetrievedTags(_ tags: [String])
}
