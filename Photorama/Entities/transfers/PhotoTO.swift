//
//  PhotoTO.swift
//  Photorama
//
//  Created by juan sicilia on 18/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotoTO {
    
    var title: String
    var photoID: String
    var remoteURL: URL
    var photoKey: String
    var dateTaken: Date
    var tags: [String]
    
    init(title: String, photoID: String, remoteURL: URL, photoKey: String, dateTaken: Date, tags: [String]) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.photoKey = photoKey
        self.dateTaken = dateTaken
        self.tags = tags
    }
}
