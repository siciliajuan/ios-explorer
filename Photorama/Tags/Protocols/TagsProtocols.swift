//
//  TagsProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import CoreData


// presenter -> view
protocol TagsViewProtocol {
    var presenter: TagsPresenterProtocol? { get set }
    
    var photo: Photo! { get set }
    
    func setTags(_ tags: [NSManagedObject])
}

// view -> presenter
protocol TagsPresenterProtocol {
    var view: TagsViewProtocol? { get set }
    var route: TagsWireFrameProtocol? { get set }
    var interactor: TagsInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func dismissTags()
    func updateTags()
    func saveTag(_ tagName: String)
    func commitPersistentData()
}

// presenter -> router
// other route -> route
protocol TagsWireFrameProtocol {
    static func createTagsModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
    func dismissTags(from: TagsViewProtocol)
}

// presenter -> interactor
protocol TagsInteractorInputProtocol {
    var presenter: TagsInteractorOutputProtocol? { get set }
    
    var store: PhotoStore! { get set }
    
    func retrieveTags()
    func saveTag(_ tagName: String)
    func saveChanges()
}


// interactor -> presenter
protocol TagsInteractorOutputProtocol {
    func didRetrievedTags(_ tags: [NSManagedObject])
}
