//
//  PhotoStore.swift
//  Photorama
//
//  Created by juan sicilia on 21/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error {
    case ImageCreationError
}

class PhotoStore {
    
    let coreDataStack = CoreDataStack(modelName: "Photorama")
    
    let imageStore = ImageStore()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(url: url as URL)
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            var result = self.processRecentPhotosRequest(data: data! as NSData, error: error)
            if case let .Success(photos) = result {
                let privateQueueContext = self.coreDataStack.privateQueueContext
                privateQueueContext.performAndWait(){
                    try! privateQueueContext.obtainPermanentIDs(for: photos)
                }
                let objectIDs = photos.map{ $0.objectID }
                let predicate = NSPredicate(format: "self IN %@", objectIDs)
                let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
                do {
                    try self.coreDataStack.saveChanges()
                    let mainQueuePhotos = try self.fetchMainQueuePhotos(predicate: predicate, sortDescriptors: [sortByDateTaken])
                    result = .Success(mainQueuePhotos)
                } catch let error {
                    result = .Failure(error)
                }
            }
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data: NSData?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return PhotosJsonHelper.photosFromJSONData(data: jsonData, inContext: self.coreDataStack.privateQueueContext)
    }
    
    
    /*
      Fetches the image for a photo Object, first try to get it from the cache but if wasn't there then
      download it using the URL and set in the store and cache. Finally exec the completion closure
     */
    func fetchImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoKey = photo.photoKey
        if let image = imageStore.imageForKey(key: photoKey) {
            photo.image = image
            completion(.Success(image))
            return
        }
        let photoURL = photo.remoteURL
        let request = NSURLRequest(url: photoURL as URL)
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data! as NSData, error: error)
            if case let .Success(image) = result {
                photo.image = image
                self.imageStore.setImage(image: image, forKey: photoKey)
            }
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data: NSData?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData as Data) else {
                if data == nil {
                    return .Failure(error!)
                } else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
    
    /*
      Return all photos that match the predicate sorted by sortDescription
     */
    func fetchMainQueuePhotos(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [Photo] {
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
    
    
    func fetchMainQueueTags(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueueTags: [NSManagedObject]?
        var fetchRequestError: Error?
        mainQueueContext.performAndWait() {
            do {
                mainQueueTags = try mainQueueContext.fetch(fetchRequest) as? [NSManagedObject]
            } catch let error {
                fetchRequestError = error
            }
        }
        guard let tags = mainQueueTags else {
            throw fetchRequestError!
        }
        return tags
    }
}
