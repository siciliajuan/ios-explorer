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
                let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
                let allPhotos = try! self.store?.fetchMainQueuePhotos(predicate: nil, sortDescriptors: [sortByDateTaken])
                OperationQueue.main.addOperation{
                    self.presenter?.didRetrievePhotos(allPhotos!)
            }
        }
    }
    
    func fetchImageForPhoto(_ photo: Photo) {
        store?.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
                OperationQueue.main.addOperation{
                    self.presenter?.didUpdateImageForPhoto(photo)
                }
        }
    }
    
}
