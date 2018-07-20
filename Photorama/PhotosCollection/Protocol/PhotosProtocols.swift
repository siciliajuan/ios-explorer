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
    
    func setPhotos(_ photos: [PhotoTO])
    func updateImageForPhoto (_ photo: PhotoTO)
}

// view -> presenter
protocol PhotosPresenterProtocol {
    var view: PhotosViewProtocol! { get set }
    var route: PhotosWireFrameProtocol! { get set }
    var interactor: PhotosInteractorInputProtocol! { get set }
    
    func viewDidLoad()
    func goToPhotoInfoView(_ photo: PhotoTO)
    func getPhotoForCell(_ photo: PhotoTO)
}

// presenter -> interactor
protocol PhotosInteractorInputProtocol {
    var presenter: PhotosInteractorOutputProtocol! { get set }
    
    var store: PhotoStore! { get set }
    
    func fetchRecentPhotos()
    func fetchImageForPhoto(_ photo: PhotoTO)
}

// interactor -> presenter
protocol PhotosInteractorOutputProtocol {
    func didRetrievePhotos(_ photos: [PhotoTO])
    func didUpdateImageForPhoto (_ photo: PhotoTO)
}

// presenter -> route
// other route -> route
protocol PhotosWireFrameProtocol {
    func presentPhotoInfo(from view: PhotosViewProtocol, photo: PhotoTO, store: PhotoStore)
}
