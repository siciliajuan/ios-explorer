//
//  PhotosCoreData.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import CoreData


enum PhotoResult {
    case success(PhotoMO)
    case failure
}

class PhotosCoreData {
    
    var coreDataStack: CoreDataStack!
    
    func getPhoto(byId id: String, completion: @escaping (PhotoResult) -> Void) {
        let predicate = NSPredicate(format: "photoID == %@", id)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoMO")
        fetchRequest.sortDescriptors = nil
        fetchRequest.predicate = predicate
        let context = coreDataStack.managedObjectMainContext!
        var contextQueuePhotos: [PhotoMO]?
        context.performAndWait() {
            do {
                contextQueuePhotos = try context.fetch(fetchRequest) as? [PhotoMO]
            } catch {
                return
            }
        }
        guard let photosMO = contextQueuePhotos, let photoMO = photosMO.first else {
            return completion(.failure)
        }
        completion(.success(photoMO))
        coreDataStack.saveChanges(context: context)
    }
    
    func persistRecentPhotos(photos: [Photo]) {
        let context = coreDataStack.managedObjectMainContext!
        photos.forEach{
            (photo) -> Void in
            getPhoto(byId: photo.photoID){
                (result) -> Void in
                if case .failure = result {
                    var photoEntity: PhotoMO!
                    context.performAndWait() {
                        photoEntity = NSEntityDescription.insertNewObject(forEntityName: "PhotoMO", into: context) as! PhotoMO
                        photoEntity.title = photo.title
                        photoEntity.photoID = photo.photoID
                        photoEntity.remoteURL = photo.remoteURL
                        photoEntity.dateTaken = photo.dateTaken
                        photoEntity.photoKey = photo.photoKey
                    }
                }
            }
        }
        coreDataStack.saveChanges(context: context)
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
        let mainQueueContext = coreDataStack.managedObjectMainContext!
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
