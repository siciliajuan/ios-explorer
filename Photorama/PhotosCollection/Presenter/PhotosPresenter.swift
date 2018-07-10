//
//  PhotosPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotosPresenter: PhotosPresenterProtocol {
    
    var view: PhotosViewProtocol?
    var route: PhotosWireFrameProtocol?
    var interactor: PhotosInteractorInputProtocol?
    
    func viewDidLoad() {
        
    }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
    
}
