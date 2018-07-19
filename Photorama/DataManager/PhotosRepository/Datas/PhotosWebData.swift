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
    case Success([PhotoTO])
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
        return photosFromJSONData(data: jsonData)
    }
    
    func photosFromJSONData(data: Data) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [String: Any],
                let photos = jsonDictionary["photos"] as? [String: AnyObject],
                let photosArray = photos["photo"] as? [[String: Any]] else {
                    return .Failure(FlickrError.InvalidJSONData)
            }
            var finalPhotos = [PhotoTO]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(json: photoJSON as [String : AnyObject]) {
                    finalPhotos.append(photo)
                }
            }
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .Failure(FlickrError.InvalidJSONData)
            }
            return .Success(finalPhotos)
        } catch let error {
            return .Failure(error)
        }
    }
    
    func photoFromJSONObject(json: [String: AnyObject]) -> PhotoTO? {
        guard
            let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = DateHelper.dateFormatter.date(from: dateString) else {
                return nil
        }
        return PhotoTO(title: title, photoID: photoID, remoteURL: url, photoKey: UUID().uuidString, dateTaken: dateTaken, tags: [])
    }
    
}
