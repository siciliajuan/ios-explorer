//
//  ImageStore.swift
//  Homepwner
//
//  Created by juan sicilia on 14/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    
    /*
     Sets a new image in the ImageStore. First it sets the
     image in the cache, then create its url where
     it is gonna try to store in the filesystem, then converts
     the image into a JPEG and try to store it there.
    */
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        let imageURL = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL as URL, options: .atomic)
            } catch {
                print("Error setting the image: \(error)")
            }
        }
    }
    
    /*
     Gets and image by its NSUUID. First try to find it in the
     cache and returns it, but if not found then try to find it
     in the file system, set in the cache and returs it.
    */
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }
    
    /*
     Deletes the image first in the cache and then in the filesystem
    */
    func deleteImageForKay(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        let imageURL = imageURLForKey(key)
        do {
            try FileManager.default.removeItem(at: imageURL as URL)
        } catch {
            print("Error removing the image from disk: \(error)")
        }
    }
    
    /*
     Prepares an filesystem URL using the image NSUUID where the image
     should be stored.
    */
    func imageURLForKey(_ key: String) -> NSURL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
}
