//
//  photoTransfer.swift
//  Photorama
//
//  Created by juan sicilia on 18/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotoTransfer {
    
    static func photoMOToPhoto(photoMO: PhotoMO) -> Photo {
        let tags = photoMO.tagsMO.map{$0.value(forKey: "name") as! String}
        return Photo(title: photoMO.title, photoID: photoMO.photoID, remoteURL: photoMO.remoteURL, photoKey: photoMO.photoKey, dateTaken: photoMO.dateTaken, tags: tags)
    }
    
    static func photosMOToPhotos (photosMO: [PhotoMO]) -> [Photo] {
        return photosMO.map{photoMOToPhoto(photoMO: $0)}
    }
    
    static func photoCodableToPhoto(photo: PhotoCodable) -> Photo? {
        guard
            let photoID = photo.photoID,
            let title = photo.title,
            let dateString = photo.dateTaken,
            let photoURLString = photo.remoteURL,
            let url = URL(string: photoURLString),
            let dateTaken = DateHelper.dateFormatter.date(from: dateString) else {
                return nil
        }
        return Photo(title: title, photoID: photoID, remoteURL: url, photoKey: UUID().uuidString, dateTaken: dateTaken, tags: [])
    }
}
