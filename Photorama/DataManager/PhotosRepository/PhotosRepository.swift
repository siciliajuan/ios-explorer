//
//  PhotosRepository.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import CoreData

class PhotosRepository {

    var tagsRepository: TagsRepository!
    var photosCoreData: PhotosCoreData!
    var photosWebData: PhotosWebData!
    
    
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void) {
        photosWebData.getRecentPhotosFromFlickrAPI() {
            (result) -> Void in
            if case let .success(photos) = result {
                self.photosCoreData.persistRecentPhotos(photos: photos)
            }
            completion()
        }
    }
    
    func getAllPersistedPhotos() throws -> [Photo] {
        return try photosCoreData.getAllPersistedPhotos()
    }
    
    func getPhoto(byId id: String, completion: @escaping (PhotoResult) -> Void) {
        photosCoreData.getPhoto(byId: id, completion: completion)
    }
    
    func update(photo: Photo) {
        getPhoto(byId: photo.photoID) {
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
