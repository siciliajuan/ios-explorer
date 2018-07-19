//
//  PhotosCoreData.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import CoreData


class PhotosCoreData {
    
    let coreDataStack: CoreDataStack
    
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    
    func persistRecentPhotos(photos: [PhotoTO]) {
        let context = coreDataStack.mainQueueContext
        for photo in photos {
            var photoEntity: Photo!
            context.performAndWait() {
                photoEntity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
                photoEntity.title = photo.title
                photoEntity.photoID = photo.photoID
                photoEntity.remoteURL = photo.remoteURL
                photoEntity.dateTaken = photo.dateTaken
                photoEntity.photoKey = photo.photoKey
            }
        }
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try fetchMainQueuePhotos()
    }
    
    /*
     Return all photos that match the predicate sorted by sortDescription
     */
    func fetchMainQueuePhotos(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = [NSSortDescriptor(key: "dateTaken", ascending: true)]) throws -> [Photo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueuePhotos: [Photo]?
        var fetchRequestError: Error?
        mainQueueContext.performAndWait() {
            do {
                mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as? [Photo]
            } catch let error {
                fetchRequestError = error
            }
        }
        guard let photos = mainQueuePhotos else {
            throw fetchRequestError!
        }
        return photos
        
    }
    
}
