//
//  MockPhotoStore.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 8/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class MockPhotoStore {
    
    var imageRepository: ImageRepository!
    var tagsRepository: TagsRepository!
    var photosRepository: PhotosRepository!
    
    // for test purpose
    
    var getTagsSortedByNameCalled = false
    var tags = [String]()
    var photo: Photo!
    
}

extension MockPhotoStore: PhotosRepositoryProtocol {
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return []
    }
    
    func update(photo: Photo) {
        self.photo = photo
    }
}

extension MockPhotoStore: ImageRepositoryProtocol {
    
    func getImage(forPhoto photo: Photo, completion: @escaping (ImageResult) -> Void) {
    }
}

extension MockPhotoStore: TagsRepositoryProtocol {
   
    func getTagsSortedByName() throws -> [String] {
        getTagsSortedByNameCalled = true
        return TestHelpers.createRandomTags(amount: 15)
    }
    
    func save(tag: String) {
        tags.append(tag)
    }
}
