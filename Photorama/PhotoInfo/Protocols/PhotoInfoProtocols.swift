//
//  PhotoInfoProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit


// presenter -> view
protocol PhotoInfoViewProtocol {
    var photo: Photo? { get set }
    
    var presenter: PhotoInfoPresenterProtocol? { get set }
    func showTags()
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage)
}


// view -> presenter
protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol? { get set }
    var route: PhotoInfoWireFrameProtocol? { get set }
    var interactor: PhotoInfoInteractorInputProtocol? { get set }
    
    func viewDidLoad(_ photo: Photo?)
    func showTags(_ photo: Photo?)
}

// presenter -> route
protocol PhotoInfoWireFrameProtocol {
    static func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
    func presentTags(from: PhotoInfoViewProtocol, photo: Photo, store: PhotoStore)
}

// presenter -> interactor
protocol PhotoInfoInteractorInputProtocol {
    var presenter: PhotoInfoInteractorOutputProtocol? { get set }
    var store: PhotoStore? { get set }
    
    func retrievePhotoImage(forPhoto photo: Photo)
}

// interactor -> presenter
protocol PhotoInfoInteractorOutputProtocol {
    func didRetrievePhotoImage(_ photo: Photo)
}
