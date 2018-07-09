//
//  TagsProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit


// View
protocol TagsViewProtocol {
    var presenter: TagsPresenterProtocol? { get set }
}

// Presenter
protocol TagsPresenterProtocol {
    var view: TagsViewProtocol? { get set }
    var wireFrame: TagsWireFrameProtocol? { get set }
    var interactor: TagsInteractorProtocol? { get set }
    
    func viewDidLoad()
}

// Router
protocol TagsWireFrameProtocol {
    static func createTagsModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
}

// Interactor
protocol TagsInteractorProtocol {
    
}
