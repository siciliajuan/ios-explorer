//
//  PhotoInfoInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoInteractor: PhotoInfoInteractorProtocol {
    
    var store: PhotoStore?
    
    var photo: Photo?
    
    func getPhotoImage(forPhoto photo: Photo) -> UIImage? {
        var returnImage: UIImage?
        store!.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                returnImage = image
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        return returnImage
    }
    
}
