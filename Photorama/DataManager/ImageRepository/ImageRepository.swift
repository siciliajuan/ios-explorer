//
//  ImageStore.swift
//  Homepwner
//
//  Created by juan sicilia on 14/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class ImageRepository: ImageRepositoryProtocol {
    
    var imageCache: ImageDataProtocol
    var imageFS: ImageDataProtocol
    
    init() {
        imageCache = ImageCacheData()
        imageFS = ImageFileData()
    }
    
    /*
     Sets a new image in the ImageStore. First it sets the
     image in the cache, then create its url where
     it is gonna try to store in the filesystem, then converts
     the image into a JPEG and try to store it there.
    */
    func setImage(image: UIImage, forKey key: String) {
        imageCache.setImage(image: image, forKey: key)
        imageFS.setImage(image: image, forKey: key)
    }
    
    /*
     Gets and image by its NSUUID. First try to find it in the
     cache and returns it, but if not found then try to find it
     in the file system, set in the cache and returs it.
    */
    func getImageByKey(key: String) -> UIImage? {
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
     Deletes the image first in the cache and then in the filesystem
    */
    func removeImageByKay(key: String) {
        imageCache.deleteImageForKay(key: key)
        imageFS.deleteImageForKay(key: key)
    }
}
