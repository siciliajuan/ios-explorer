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
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        // Create full URL for iamge
        let imageURL = imageURLForKey(key)
        
        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // Write it to full URL
            do {
                try data.write(to: imageURL as URL, options: .atomic)
            } catch {
                print("Error setting the image: \(error)")
            }
        }
    }
    
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
    
    func deleteImageForKay(key: String) {
        cache.removeObject(forKey: key as AnyObject)
        let imageURL = imageURLForKey(key)
        do {
            try FileManager.default.removeItem(at: imageURL as URL)
        } catch {
            print("Error removing the image from disk: \(error)")
        }
    }
    
    func imageURLForKey(_ key: String) -> NSURL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
}
