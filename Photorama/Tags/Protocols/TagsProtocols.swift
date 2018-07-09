//
//  TagsProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import CoreData


// View
protocol TagsViewProtocol {
    var presenter: TagsPresenterProtocol? { get set }
    
    func done(sender: AnyObject)
    func addNewTag(sender: AnyObject)
}

// Presenter
protocol TagsPresenterProtocol {
    var view: TagsViewProtocol? { get set }
    var route: TagsWireFrameProtocol? { get set }
    var interactor: TagsInteractorProtocol? { get set }
    
    var photo: Photo! { get set }
    var selectedIndexPaths: [NSIndexPath] { get set }
    var tags: [NSManagedObject] { get set }
    
    func viewDidLoad()
    func updateTags()
    func dismissTags()
    func getTagByIndex(index: IndexPath) -> NSManagedObject
    func getTagsAmount() -> Int
}

// Router
protocol TagsWireFrameProtocol {
    static func createTagsModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
    func dismissTags(from: UIViewController)
}

// Interactor
protocol TagsInteractorProtocol {
    var store: PhotoStore! { get set }
}
