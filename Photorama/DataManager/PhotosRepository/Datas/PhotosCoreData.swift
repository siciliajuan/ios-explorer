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
    
    
    func getPhotoById(id: String) -> PhotoMO? {
        let predicate = NSPredicate(format: "photoID == %@", id)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoMO")
        fetchRequest.sortDescriptors = nil
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.managedObjectContext
        var mainQueuePhotos: [PhotoMO]?
        mainQueueContext.performAndWait() {
            do {
                mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as? [PhotoMO]
            } catch {
                return
            }
        }
        guard let photosMO = mainQueuePhotos, let photoMO = photosMO.first else {
            return nil
        }
        return photoMO
    }
    
    func persistRecentPhotos(photos: [Photo]) {
        let context = coreDataStack.managedObjectContext
        _ = photos.map{
            (photo) -> Void in
            guard let _ = getPhotoById(id: photo.photoID) else {
                var photoEntity: PhotoMO!
                context.performAndWait() {
                    photoEntity = NSEntityDescription.insertNewObject(forEntityName: "PhotoMO", into: context) as! PhotoMO
                    photoEntity.title = photo.title
                    photoEntity.photoID = photo.photoID
                    photoEntity.remoteURL = photo.remoteURL
                    photoEntity.dateTaken = photo.dateTaken
                    photoEntity.photoKey = photo.photoKey
                }
                return
            }
        }
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        let photosMO = try fetchMainQueuePhotos()
        return PhotoTransfer.photosMOToPhotos(photosMO: photosMO)
    }
    
    /*
     Return all photos that match the predicate sorted by sortDescription
     */
    func fetchMainQueuePhotos(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = [NSSortDescriptor(key: "dateTaken", ascending: true)]) throws -> [PhotoMO] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoMO")
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.managedObjectContext
        var mainQueuePhotos: [PhotoMO]?
        var fetchRequestError: Error?
        mainQueueContext.performAndWait() {
            do {
                mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as? [PhotoMO]
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
