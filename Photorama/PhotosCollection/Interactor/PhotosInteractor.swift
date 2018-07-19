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
            OperationQueue.main.addOperation{
                let allPhotos = try! self.store.getAllPersistedPhotos()
                self.presenter.didRetrievePhotos(allPhotos)
            }
        }
    }
    
    func fetchImageForPhoto(_ photo: Photo) {
        store.getImageForPhoto(photo: photo) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                photo.image = image
                OperationQueue.main.addOperation{
                    self.presenter.didUpdateImageForPhoto(photo)
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
