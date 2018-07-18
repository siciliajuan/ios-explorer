//
//  ImageWebData.swift
//  Photorama
//
//  Created by juan sicilia on 17/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error {
    case ImageCreationError
}

class ImageWebData {
    
    
    /*
     Fetches the image for a photo Object, first try to get it from the cache but if wasn't there then
     download it using the URL and set in the store and cache. Finally exec the completion closure
     */
    func getImageByUrl(_ url: URL, completion: @escaping (ImageResult) -> Void) {
        let request = NSURLRequest(url: url)
        let task = WebServicesHelper.session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data!, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .Failure(error!)
                } else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
    
}
