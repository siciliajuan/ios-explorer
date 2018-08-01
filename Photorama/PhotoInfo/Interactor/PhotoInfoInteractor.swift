//
//  PhotoInfoInteractor.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoInteractor: PhotoInfoInteractorInputProtocol {
    
    var presenter: PhotoInfoInteractorOutputProtocol!
    
    var store: PhotoStore!
    
    func retrieveImage(forPhoto photo: Photo){
        store.getImage(forPhoto: photo) {
            (result) -> Void in
            switch result {
            case let .success(image):
                photo.image = image
                self.presenter.didRetrieveImage(forPhoto: photo)
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
