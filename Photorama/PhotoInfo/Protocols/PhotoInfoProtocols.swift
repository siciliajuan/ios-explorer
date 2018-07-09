//
//  PhotoInfoProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit


// View protocols
protocol PhotoInfoViewProtocol {
    var presenter: PhotoInfoPresenterProtocol? { get set }
    func showTags()
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage)
}


// Presenter protocols
protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol? { get set }
    var wireFrame: PhotoInfoWireFrameProtocol? { get set }
    var interactor: PhotoInfoInteractorProtocol? { get set }
    var photo: Photo? { get set }
    
    func viewDidLoad()
}

// Router protocols
protocol PhotoInfoWireFrameProtocol {
    static func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
}

// Interactor protocols
protocol PhotoInfoInteractorProtocol {
    var store: PhotoStore? { get set }
    
    func getPhotoImage(forPhoto photo: Photo) -> UIImage?
}
