//
//  PhotoInfoPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotoInfoPresenter: PhotoInfoPresenterProtocol {
    
    var view: PhotoInfoViewProtocol?
    var wireFrame: PhotoInfoWireFrameProtocol?
    var store: PhotoStore?
    var photo: Photo?
    
    func viewDidLoad() {
        view?.showPhotoInfo(forPhoto: photo!, forPhotoStore: store!)
    }
    
}
