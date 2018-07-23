//
//  ImageCacheData.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class ImageCacheData {
    
    let cache = NSCache<AnyObject, AnyObject>()

    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func getImage(byKey key: String) -> UIImage? {
        guard let existingImage = cache.object(forKey: key as AnyObject) as? UIImage else {
            return nil
        }
        return existingImage
    }
}
