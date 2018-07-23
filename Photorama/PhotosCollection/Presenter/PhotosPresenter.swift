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
    
    func didShowPhotoInfoView(forPhoto photo: Photo) {
        route.presentPhotoInfoVC(from: view!, photo: photo, store: interactor.store!)
    }
    
    func getImageCell(forPhoto photo: Photo) {
        interactor.fetchImage(forPhoto: photo)
    }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
    
    func didRetrievePhotos(_ photos: [Photo]) {
        view.setPhotos(photos)
    }
    
    func didRetrievedImage(forPhoto photo: Photo) {
        view.updateImage(forPhoto: photo)
    }
    
}
