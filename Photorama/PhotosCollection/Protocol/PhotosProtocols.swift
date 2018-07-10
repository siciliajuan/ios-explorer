//
//  PhotosProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

// presenter -> view
protocol PhotosViewProtocol {
    var presenter: PhotosPresenterProtocol? { get set }
}

// view -> presenter
protocol PhotosPresenterProtocol {
    var view: PhotosViewProtocol? { get set }
    var route: PhotosWireFrameProtocol? { get set }
    var interactor: PhotosInteractorInputProtocol? { get set }
    
    func viewDidLoad()
}

// presenter -> interactor
protocol PhotosInteractorInputProtocol {
    var presenter: PhotosInteractorOutputProtocol? { get set }
    
    var store: PhotoStore? { get set }
}

// interactor -> presenter
protocol PhotosInteractorOutputProtocol {
    
}

// presenter -> route
// other route -> route
protocol PhotosWireFrameProtocol {
    
}
