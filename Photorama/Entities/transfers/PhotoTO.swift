//
//  PhotoTO.swift
//  Photorama
//
//  Created by juan sicilia on 18/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoTO: Equatable {
    
    var title: String
    var photoID: String
    var remoteURL: URL
    var photoKey: String
    var dateTaken: Date
    var image: UIImage?
    var tags: [String]
    
    init(title: String, photoID: String, remoteURL: URL, photoKey: String, dateTaken: Date, tags: [String]) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.photoKey = photoKey
        self.dateTaken = dateTaken
        self.tags = tags
    }
    
    func removeTagObject(tag: String) {
        if let index = tags.index(of: tag) {
            tags.remove(at: index)
        }
    }
    
    func addTagObject(tag: String) {
        tags.append(tag)
    }
    
    static func == (lhs: PhotoTO, rhs: PhotoTO) -> Bool {
        return lhs.title == rhs.title && lhs.photoID == rhs.photoID &&
               lhs.remoteURL == rhs.remoteURL && lhs.photoKey == rhs.photoKey &&
               lhs.dateTaken == rhs.dateTaken
    }
}
