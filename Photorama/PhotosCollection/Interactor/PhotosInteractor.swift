//
//  PhotosInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotosInteractor: PhotosInteractorInputProtocol {
    
    
    var presenter: PhotosInteractorOutputProtocol!

    var store: PhotoStore!
    
    
    func fetchRecentPhotos() {
        store.fetchLastUploadedFlickerPhotos() {
            () -> Void in
            let allPhotos = try! self.store.getAllPersistedPhotos()
            self.presenter.didRetrievePhotos(allPhotos)
        }
    }
    
    func fetchImage(forPhoto photo: Photo) {
        store.getImage(forPhoto: photo) {
            (result) -> Void in
            switch result {
            case let .success(image):
                photo.image = image
                OperationQueue.main.addOperation{
                    self.presenter.didRetrievedImage(forPhoto: photo)
                }
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
