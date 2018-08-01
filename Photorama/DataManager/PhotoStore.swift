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
    
    let imageRepository: ImageRepository
    let tagsRepository: TagsRepository
    let photosRepository: PhotosRepository
    
    init() {
        let tagsCoreData = TagsCoreData(coreDataStack: coreDataStack)
        self.tagsRepository = TagsRepository(tagsCoreData: tagsCoreData)
        
        let imageCache = ImageCacheData()
        let imageFileSystem = ImageFileData()
        let imageWebData = ImageWebData()
        self.imageRepository = ImageRepository(imageCache: imageCache, imageFileSystem: imageFileSystem, imageWebData: imageWebData)
        
        let photosCoreData = PhotosCoreData(coreDataStack: coreDataStack)
        let photosWebData = PhotosWebData()
        self.photosRepository = PhotosRepository(photosCoreData: photosCoreData, photosWebData: photosWebData)
    }
    
    func update(photo: Photo) {
        photosRepository.getPhoto(byId: photo.photoID) {
            (result) -> Void in
            switch result {
            case let .success(photoMO):
                guard let tagsMO = self.tagsRepository.getTags(byNameList: photo.tags) else {
                    print("Error trying to retrieved tags by photo: \(photo)")
                    return
                }
                tagsMO.forEach{photoMO.addTagObject(tagMO: $0)}
            case .failure:
                print("Error trying to retrieved photo by id: \(photo.photoID)")
                return
            }
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
