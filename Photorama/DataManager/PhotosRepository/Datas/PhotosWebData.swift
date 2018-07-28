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
    case success([Photo])
    case failure(Error)
}

/*
 This Error is for when trying to serialize the JSON from photosData
 there are some JSON error
 */
enum FlickrError: Error {
    case invalidJSONData
}

class PhotosWebData {
    
    func getRecentPhotosFromFlickrAPI(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        URLSession.shared.dataTask(with: url) { [weak self]
            (data, response, error) -> Void in
            guard let result = self?.processRecentPhotosRequest(data: data, error: error) else {
                completion(.failure(FlickrError.invalidJSONData))
                return
            }
            OperationQueue.main.addOperation{
                completion(result)
            }
        }.resume()
    }
    
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return photos(fromJSONData: jsonData)
    }
    
    func photos(fromJSONData data: Data) -> PhotosResult {
        do {
            let decoder = JSONDecoder()
            let photosArray = try decoder.decode(PhotosCodable.self, from: data)
            guard let photos = photosArray.resultPhotos else {
                return .failure(FlickrError.invalidJSONData)
            }
            let finalPhotos = photos.compactMap{PhotoTransfer.photoCodableToPhoto(photo: $0)}
            if finalPhotos.count == 0 && photos.count > 0 {
                return .failure(FlickrError.invalidJSONData)
            }
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }

    }
}
