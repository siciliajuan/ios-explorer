//
//  PhotoStore.swift
//  Photorama
//
//  Created by juan sicilia on 21/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

class PhotoStore {
    
    let coreDataStack = CoreDataStack(modelName: "Photorama")
    
    let imageRepository = ImageRepository()
    let tagsRepository: TagsRepository
    let photosRepository: PhotosRepository
    
    init() {
        self.tagsRepository = TagsRepository(coreDataStack: coreDataStack)
        self.photosRepository = PhotosRepository(coreDataStack: coreDataStack)
    }
    
    func saveChanges() {
        do {
            try coreDataStack.saveChanges()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
    }
}

extension PhotoStore: PhotosRepositoryProtocol {
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        photosRepository.fetchLastUploadedFlickerPhotos(completion: completion)
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosRepository.getAllPersistedPhotos()
    }
    
    func update(photo: Photo) {
        guard
            let photoMO = photosRepository.getPhoto(byId: photo.photoID),
            let tagsMO = tagsRepository.getTags(byNameList: photo.tags)
        else {
            print("Error trying to retrieved photo by id: \(photo.photoID)")
            return
        }
        _ = tagsMO.map{photoMO.addTagObject(tagMO: $0)}
        saveChanges()
    }
}

extension PhotoStore: ImageRepositoryProtocol {
    
    func getImage(forPhoto photo: Photo, completion: @escaping (ImageResult) -> Void) {
        imageRepository.getImage(forPhoto: photo, completion: completion)
    }
}

extension PhotoStore: TagsRepositoryProtocol {
    
    func getTagsSortedByName() throws -> [String] {
        return try tagsRepository.getTagsSortedByName()
    }
    
    func save(tag: String) {
        tagsRepository.save(tag: tag)
        saveChanges()
    }
}
