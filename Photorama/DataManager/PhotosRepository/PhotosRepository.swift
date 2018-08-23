//
//  PhotosRepository.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import CoreData

class PhotosRepository {

    var photosCoreData: PhotosCoreData
    var photosWebData: PhotosWebData
    
    init (photosCoreData: PhotosCoreData, photosWebData: PhotosWebData) {
        self.photosCoreData = photosCoreData
        self.photosWebData = photosWebData
    }
    
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        photosWebData.getRecentPhotosFromFlickrAPI() {
            (result) -> Void in
            if case let .success(photos) = result {
                self.photosCoreData.persistRecentPhotos(photos: photos)
            }
            OperationQueue.main.addOperation{
                completion()
            }
        }
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosCoreData.getAllPersistedPhotos()
    }
    
    func update(photo: Photo) {
        photosCoreData.update(photo: photo)
    }
    
}
