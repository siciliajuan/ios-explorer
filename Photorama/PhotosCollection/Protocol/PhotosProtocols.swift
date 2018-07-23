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
    var presenter: PhotosPresenterProtocol! { get set }
    
    func setPhotos(_ photos: [Photo])
    func updateImage(forPhoto photo: Photo)
}

// view -> presenter
protocol PhotosPresenterProtocol {
    var view: PhotosViewProtocol! { get set }
    var route: PhotosWireFrameProtocol! { get set }
    var interactor: PhotosInteractorInputProtocol! { get set }
    
    func viewDidLoad()
    func didShowPhotoInfoView(forPhoto photo: Photo)
    func getImageCell(forPhoto photo: Photo)
}

// presenter -> interactor
protocol PhotosInteractorInputProtocol {
    var presenter: PhotosInteractorOutputProtocol! { get set }
    
    var store: PhotoStore! { get set }
    
    func fetchRecentPhotos()
    func fetchImage(forPhoto photo: Photo)
}

// interactor -> presenter
protocol PhotosInteractorOutputProtocol {
    func didRetrievePhotos(_ photos: [Photo])
    func didRetrievedImage(forPhoto photo: Photo)
}

// presenter -> route
// other route -> route
protocol PhotosWireFrameProtocol {
    func presentPhotoInfoVC(from view: PhotosViewProtocol, photo: Photo, store: PhotoStore)
}
