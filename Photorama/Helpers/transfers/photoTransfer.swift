//
//  photoTransfer.swift
//  Photorama
//
//  Created by juan sicilia on 18/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotoTransfer {
    
    static func photoToPhotoTO(photo: Photo) -> PhotoTO {
        var tags = [String]()
        for tag in photo.tags {
            tags.append(tag.value(forKey: "name") as! String)
        }
        return PhotoTO(title: photo.title, photoID: photo.photoID, remoteURL: photo.remoteURL, photoKey: photo.photoKey, dateTaken: photo.dateTaken, tags: tags)
    }
    
    static func photosToPhotosTO (photos: [Photo]) -> [PhotoTO] {
        var photosTO = [PhotoTO]()
        for photo in photos {
            photosTO.append(photoToPhotoTO(photo: photo))
        }
        return photosTO
    }
}
