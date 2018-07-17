//
//  ImageDataProtocol.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

protocol ImageRepositoryProtocol {
    
    func setImage(image: UIImage, forKey key: String)
    func getImageByKey(key: String) -> UIImage?
    func removeImageByKay(key: String)
}

protocol ImageDataProtocol {
    
    func setImage(image: UIImage, forKey key: String)
    func imageForKey(key: String) -> UIImage?
    func deleteImageForKay(key: String)
}
