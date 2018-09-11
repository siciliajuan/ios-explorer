//
//  FlickrAPI2.swift
//  Photorama
//
//  Created by juan sicilia on 10/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

enum FlickrAPI2 {
    case recentPhotos
}

extension FlickrAPI2: Resource {
    
    var path: String {
        switch self {
        case .recentPhotos:
            return ""
        }
    }
        
    var parameters: [String: String] {
        switch self {
        case .recentPhotos:
            return [
                "method": "flickr.photos.getRecent",
                "format": "json",
                "nojsoncallback": "1",
                "api_key": "a6d819499131071f158fd740860a5a88",
                "extras":"url_h,date_taken"
            ]
        }
    }
}


extension URL {
    static func flickrURL() -> URL {
        return URL(string: "https://api.flickr.com/services/rest")!
    }
}

extension APIClient {
    public class func flickrAPIClient() -> APIClient {
        return APIClient(baseURL: URL.flickrURL())
    }
    
    public func fetchRecentPhotos() {
        objects(resource: FlickrAPI2.recentPhotos) { (photosCodable: PhotosCodable) in
            print("Done mi arma!")
        }
    }
}
