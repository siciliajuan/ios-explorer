//
//  FlickrAPI.swift
//  Photorama
//
//  Created by juan sicilia on 20/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import Foundation

/*
 Keeps the posible method that will be used when creating the
 URL to call the flickr API
 */
enum Method: String {
    case recentPhotos = "flickr.photos.getRecent"
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static func flickrURL(method: Method, parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        // reducir
        _ = baseParams.map{ key, value in queryItems.append(URLQueryItem(name: key, value: value))}
        if let additionalParams = parameters {
            _ = additionalParams.map{ key, value in queryItems.append(URLQueryItem(name: key, value: value))}
        }
        components.queryItems = queryItems as [URLQueryItem]
        return components.url!
    }
    
    static func recentPhotosURL() -> URL {
        return flickrURL(method: .recentPhotos, parameters: ["extras":"url_h,date_taken"])
    }
  
}
