//
//  ImageStore.swift
//  Homepwner
//
//  Created by juan sicilia on 14/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class ImageRepository: ImageRepositoryProtocol {
    
    var imageCache: ImageCacheData
    var imageFS: ImageFileData
    var imageWebData: ImageWebData
    
    init() {
        imageCache = ImageCacheData()
        imageFS = ImageFileData()
        imageWebData = ImageWebData()
    }
    
    /*
     Sets a new image in the ImageStore. First it sets the
     image in the cache, then create its url where
     it is gonna try to store in the filesystem, then converts
     the image into a JPEG and try to store it there.
    */
    private func setImage(image: UIImage, forKey key: String) {
        imageCache.setImage(image: image, forKey: key)
        imageFS.setImage(image: image, forKey: key)
    }
    
    /*
     Gets and image by its NSUUID. First try to find it in the
     cache and returns it, but if not found then try to find it
     in the file system, set in the cache and returs it.
    */
    private func getImageByKey(key: String) -> UIImage? {
        guard let cachedImage = imageCache.imageForKey(key: key) else {
            if let storedImage = imageFS.imageForKey(key: key) {
                imageCache.setImage(image: storedImage, forKey: key)
                return storedImage
            } else {
                return nil
            }
        }
        return cachedImage
    }
    
    
    /*
     Fetches the image for a photo Object, first try to get it from the cache but if wasn't there then
     download it using the URL and set in the store and cache. Finally exec the completion closure
     */
    func getImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoKey = photo.photoKey
        if let image = getImageByKey(key: photoKey) {
            photo.image = image
            completion(.Success(image))
            return
        }
        imageWebData.getImageByUrl(photo.remoteURL) {
            (result) -> Void in
            if case let .Success(image) = result {
                self.setImage(image: image, forKey: photoKey)
            }
            completion(result)
        }
    }
}
