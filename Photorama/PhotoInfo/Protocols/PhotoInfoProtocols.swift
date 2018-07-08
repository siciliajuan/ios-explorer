//
//  PhotoInfoProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit


protocol PhotoInfoViewProtocol {
    var presenter: PhotoInfoPresenterProtocol? { get set }
    func showPhotoInfo(forPhoto photo: Photo, forPhotoStore store: PhotoStore)
}

protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol? { get set }
    var wireFrame: PhotoInfoWireFrameProtocol? { get set }
    var store: PhotoStore? { get set }
    var photo: Photo? { get set }
    
    func viewDidLoad()
}

protocol PhotoInfoWireFrameProtocol {
    static func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController
}
