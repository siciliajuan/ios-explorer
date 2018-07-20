//
//  RecentPhotosCodable.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

struct RecentPhotosCodable: Codable {
    
    let photos: PhotosCodable?
    
    private enum CodingKeys: String, CodingKey {
        case photos
    }
}

struct PhotosCodable: Codable {
    
    let resultPhotos: [PhotoCodable]?
    
    enum CodingKeys: String, CodingKey {
        case photos
        case resultPhotos = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        resultPhotos = try photos.decode([PhotoCodable].self, forKey: .resultPhotos)
    }
    
    func encode(to encoder: Encoder) throws {
        // great stuff here
    }
}


struct PhotoCodable: Codable {
    
    var title: String?
    var photoID: String?
    var remoteURL: String?
    var dateTaken: String?
    
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case title
        case remoteURL = "url_h"
        case dateTaken = "datetaken"
    }
}
