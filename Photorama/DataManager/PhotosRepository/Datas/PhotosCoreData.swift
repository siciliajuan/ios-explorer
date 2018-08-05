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
        let context = coreDataStack.getNewManagedObjectContext()!
        var queuePhotos: [PhotoMO]?
        context.performAndWait() {
            do {
                queuePhotos = try context.fetch(fetchRequest) as? [PhotoMO]
            } catch {
                return
            }
        }
        guard let photosMO = queuePhotos, let photoMO = photosMO.first else {
            return completion(.failure)
        }
        completion(.success(photoMO))
    }
    
    func update(photo: Photo) {
        let tagsPredicate = NSPredicate(format: "name IN %@", photo.tags)
        let tagsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        tagsFetchRequest.sortDescriptors = nil
        tagsFetchRequest.predicate = tagsPredicate
        let photoPredicate = NSPredicate(format: "photoID == %@", photo.photoID)
        let photoFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoMO")
        photoFetchRequest.sortDescriptors = nil
        photoFetchRequest.predicate = photoPredicate
        let context = coreDataStack.getNewManagedObjectContext()!
        var queuePhotos: [PhotoMO]?
        var queueTags: [NSManagedObject]?
        context.performAndWait() {
            do {
                queuePhotos = try context.fetch(photoFetchRequest) as? [PhotoMO]
                queueTags = try context.fetch(tagsFetchRequest) as? [NSManagedObject]
            } catch {
                return
            }
        }
        guard
            let photosMO = queuePhotos,
            let photoMO = photosMO.first,
            let tagsMO = queueTags else {
            return
        }
        tagsMO.forEach{photoMO.addTagObject(tagMO: $0)}
        coreDataStack.saveChanges(context: context)
    }
    
    func persistRecentPhotos(photos: [Photo]) {
        let context = coreDataStack.getNewManagedObjectContext()!
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
