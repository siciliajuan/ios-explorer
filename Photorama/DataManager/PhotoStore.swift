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
    
    func getAllPersistedPhotos() throws -> [PhotoTO] {
        return try photosRepository.getAllPersistedPhotos()
    }
    
    func updatePhoto(photo photoTO: PhotoTO) {
        let photo = photosRepository.getPhotoById(id: photoTO.photoID)
        if let resultPhoto = photo {
            let tags = tagsRepository.getTagsByNameList(names: photoTO.tags)
            if let resultTags = tags {
                for tag in resultTags {
                    resultPhoto.addTagObject(tag: tag)
                    saveChanges()
                }
            }
        }
    }
}

extension PhotoStore: ImageRepositoryProtocol {
    
    func getImageForPhoto(photo: PhotoTO, completion: @escaping (ImageResult) -> Void) {
        imageRepository.getImageForPhoto(photo: photo, completion: completion)
    }
}

extension PhotoStore: TagsRepositoryProtocol {
    
    func getTagsSortedByName() throws -> [String] {
        return try tagsRepository.getTagsSortedByName()
    }
    
    func saveTag(_ tagName: String) {
        tagsRepository.saveTag(tagName)
    }
}
