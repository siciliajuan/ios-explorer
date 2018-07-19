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
}

extension PhotoStore: ImageRepositoryProtocol {
    
    func getImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        imageRepository.getImageForPhoto(photo: photo, completion: completion)
    }
}

extension PhotoStore: TagsRepositoryProtocol {
    
    func getTagsSortedByName() throws -> [NSManagedObject] {
        return try tagsRepository.getTagsSortedByName()
    }
    
    func saveTag(_ tagName: String) {
        tagsRepository.saveTag(tagName)
    }
}
