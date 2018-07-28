//
//  ImageWebData.swift
//  Photorama
//
//  Created by juan sicilia on 17/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class ImageWebData {
    
    
    /*
     Fetches the image for a photo Object, first try to get it from the cache but if wasn't there then
     download it using the URL and set in the store and cache. Finally exec the completion closure
     */
    func getImage(byUrl url: URL, completion: @escaping (ImageResult) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) -> Void in
            // check if self weak inside a block or closure
            let result = self.processImageRequest(data: data!, error: error)
            completion(result)
        }.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
    
}
