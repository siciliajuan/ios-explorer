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
    func updateImageForPhoto (_ photo: Photo)
}

// view -> presenter
protocol PhotosPresenterProtocol {
    var view: PhotosViewProtocol! { get set }
    var route: PhotosWireFrameProtocol! { get set }
    var interactor: PhotosInteractorInputProtocol! { get set }
    
    func viewDidLoad()
    func goToPhotoInfoView(_ photo: Photo)
    func getPhotoForCell(_ photo: Photo)
}

// presenter -> interactor
protocol PhotosInteractorInputProtocol {
    var presenter: PhotosInteractorOutputProtocol? { get set }
    
    var store: PhotoStore? { get set }
    
    func fetchRecentPhotos()
    func fetchImageForPhoto(_ photo: Photo)
}

// interactor -> presenter
protocol PhotosInteractorOutputProtocol {
    func didRetrievePhotos(_ photos: [Photo])
    func didUpdateImageForPhoto (_ photo: Photo)
}

// presenter -> route
// other route -> route
protocol PhotosWireFrameProtocol {
    func presentPhotoInfo(from view: PhotosViewProtocol, photo: Photo, store: PhotoStore) 
}
