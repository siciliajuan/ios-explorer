//
//  ImageFileData.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class ImageFileData {
    
    func imageURLForKey(_ key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(image: UIImage, forKey key: String) {
        let imageURL = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL as URL, options: .atomic)
            } catch {
                print("Error setting the image: \(error)")
            }
        }
    }
    
    
    func getImage(byKey key: String) -> UIImage? {
        let imageURL = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        return imageFromDisk
    }
}
