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
    
    
    init(coreDataStack: CoreDataStack) {
        photosCoreData = PhotosCoreData(coreDataStack: coreDataStack)
        photosWebData = PhotosWebData()
    }
    
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        photosWebData.getRecentPhotosFromFlickrAPI() {
            (result) -> Void in
            if case let .Success(photos) = result {
                self.photosCoreData.persistRecentPhotos(photos: photos)
            }
            completion()
        }
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosCoreData.getAllPersistedPhotos()
    }
    
    func getPhoto(byId id: String) -> PhotoMO? {
        return photosCoreData.getPhoto(byId: id)
    }
    
}
