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
    var photo: PhotoTO! { get set }
    
    var presenter: PhotoInfoPresenterProtocol! { get set }
    func showTags()
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage)
}


// view -> presenter
protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol! { get set }
    var route: PhotoInfoWireFrameProtocol! { get set }
    var interactor: PhotoInfoInteractorInputProtocol! { get set }
    
    func viewDidLoad(_ photo: PhotoTO?)
    func goToTagsView(_ photo: PhotoTO?)
}

// presenter -> route
// other route -> route
protocol PhotoInfoWireFrameProtocol {
    static func createPhotoInfoModule(forPhoto photo: PhotoTO, forPhotoStore photoStore: PhotoStore) -> UIViewController
    func presentTags(from: PhotoInfoViewProtocol, photo: PhotoTO, store: PhotoStore)
}

// presenter -> interactor
protocol PhotoInfoInteractorInputProtocol {
    var presenter: PhotoInfoInteractorOutputProtocol! { get set }
    var store: PhotoStore! { get set }
    
    func retrievePhotoImage(forPhoto photo: PhotoTO)
}

// interactor -> presenter
protocol PhotoInfoInteractorOutputProtocol {
    func didRetrievePhotoImage(_ photo: PhotoTO)
}
