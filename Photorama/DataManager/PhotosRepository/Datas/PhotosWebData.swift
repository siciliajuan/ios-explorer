//
//  PhotosWebData.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

/*
 This enum gives the list of Photos as Success after convert
 them from the request data to the Photo Object or an Error as
 Failure if somethhing went wrong
 */
enum PhotosResult {
    case Success([Photo])
    case Failure(Error)
}

/*
 This Error is for when trying to serialize the JSON from photosData
 there are some JSON error
 */
enum FlickrError: Error {
    case InvalidJSONData
}

class PhotosWebData {
    
    func getRecentPhotosFromFlickrAPI(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        URLSession.shared.dataTask(with: url) {
            (data, response, error) -> Void in
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }.resume()
    }
    
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return photos(fromJSONData: jsonData)
    }
    
    func photos(fromJSONData data: Data) -> PhotosResult {
        do {
            let decoder = JSONDecoder()
            let photosArray = try decoder.decode(PhotosCodable.self, from: data)
            guard let photos = photosArray.resultPhotos else {
                return .Failure(FlickrError.InvalidJSONData)
            }
            let finalPhotos = photos.map{PhotoTransfer.photoCodableToPhoto(photo: $0)}.filter{$0 != nil}
            if finalPhotos.count == 0 && photos.count > 0 {
                return .Failure(FlickrError.InvalidJSONData)
            }
            return .Success(finalPhotos as! [Photo])
        } catch let error {
            return .Failure(error)
        }

    }
}
