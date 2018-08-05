//
//  PhotoInfoPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class PhotoInfoPresenter: PhotoInfoPresenterProtocol {
    
    
    var view: PhotoInfoViewProtocol!
    var route: PhotoInfoWireFrameProtocol!
    var interactor: PhotoInfoInteractorInputProtocol!
    
    func viewDidLoad(_ photo: Photo) {
        interactor.retrieveImage(forPhoto: photo)
        
    }
    
    func didShowTags(forPhoto photo: Photo) {
        route.presentTagsVC(from: view!, photo: photo, store: interactor!.store!)
    }
}

extension PhotoInfoPresenter: PhotoInfoInteractorOutputProtocol {
    
    func didRetrieveImage(forPhoto photo: Photo) {
        view.showPhotoInfo(forPhoto: photo.title, forImage: photo.image!)
    }
}
