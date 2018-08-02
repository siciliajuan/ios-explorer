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
    var photo: Photo! { get set }
    
    var presenter: PhotoInfoPresenterProtocol! { get set }
    func showTags()
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage)
}


// view -> presenter
protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol! { get set }
    var route: PhotoInfoWireFrameProtocol! { get set }
    var interactor: PhotoInfoInteractorInputProtocol! { get set }
    
    func viewDidLoad(_ photo: Photo)
    func didShowTags(forPhoto photo: Photo)
}

// presenter -> route
// other route -> route
protocol PhotoInfoWireFrameProtocol {
    static func createPhotoInfoModuleVC(forPhoto photo: Photo) -> UIViewController
    func presentTagsVC(from: PhotoInfoViewProtocol, photo: Photo, store: PhotoStore)
}

// presenter -> interactor
protocol PhotoInfoInteractorInputProtocol {
    var presenter: PhotoInfoInteractorOutputProtocol! { get set }
    var store: PhotoStore! { get set }
    
    func retrieveImage(forPhoto photo: Photo)
}

// interactor -> presenter
protocol PhotoInfoInteractorOutputProtocol {
    func didRetrieveImage(forPhoto photo: Photo)
}
