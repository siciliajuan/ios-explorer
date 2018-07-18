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
    
    init(coreDataStack: CoreDataStack) {
        photosCoreData = PhotosCoreData(coreDataStack: coreDataStack)
    }
    
    func getLastUploadedFlickerPhotos(completion: @escaping (PhotosResult) -> Void) {
        photosCoreData.fetchRecentPhotos(completion: completion)
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosCoreData.getAllPersistedPhotos()
    }
    
}
