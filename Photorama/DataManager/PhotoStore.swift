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
    
    var imageRepository: ImageRepository!
    var tagsRepository: TagsRepository!
    var photosRepository: PhotosRepository!
    
}

extension PhotoStore: PhotosRepositoryProtocol {
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        photosRepository.fetchLastUploadedFlickerPhotos(completion: completion)
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosRepository.getAllPersistedPhotos()
    }
    
    func update(photo: Photo) {
        photosRepository.update(photo: photo)
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
    }
}
