//
//  PhotoInfoInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoInteractor: PhotoInfoInteractorInputProtocol {
    
    var presenter: PhotoInfoInteractorOutputProtocol?
    
    var store: PhotoStore?
    
    func retrievePhotoImage(forPhoto photo: Photo){
        store!.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                photo.image = image
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        presenter?.didRetrievePhotoImage(photo)
    }
    
}
