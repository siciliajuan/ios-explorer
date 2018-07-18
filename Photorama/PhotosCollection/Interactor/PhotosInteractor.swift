//
//  PhotosInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotosInteractor: PhotosInteractorInputProtocol {
    
    var presenter: PhotosInteractorOutputProtocol?

    var store: PhotoStore?
    
    
    func fetchRecentPhotos() {
        store?.fetchRecentPhotos() {
            (result) -> Void in
                let allPhotos = try! self.store?.fetchMainQueuePhotos()
                OperationQueue.main.addOperation{
                    self.presenter?.didRetrievePhotos(allPhotos!)
            }
        }
    }
    
    func fetchImageForPhoto(_ photo: Photo) {
        store?.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            if case let .Success(image) = result {
                photo.image = image
                OperationQueue.main.addOperation{
                    self.presenter?.didUpdateImageForPhoto(photo)
                }
            }
            if case let .Failure(error) = result {
                print("Error getting photo image, error: \(error)")
            }
        }
    }
    
}
