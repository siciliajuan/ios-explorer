//
//  PhotosPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotosPresenter: PhotosPresenterProtocol {
    
    var view: PhotosViewProtocol!
    var route: PhotosWireFrameProtocol!
    var interactor: PhotosInteractorInputProtocol!
    
    func viewDidLoad() {
        interactor.fetchRecentPhotos()
    }
    
    func goToPhotoInfoView(_ photo: Photo) {
        route.presentPhotoInfo(from: view!, photo: photo, store: interactor.store!)
    }
    
    func getPhotoForCell(_ photo: Photo) {
        interactor.fetchImageForPhoto(photo)
    }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
    
    func didRetrievePhotos(_ photos: [Photo]) {
        view.setPhotos(photos)
    }
    
    func didUpdateImageForPhoto (_ photo: Photo) {
        view.updateImageForPhoto(photo)
    }
    
}
