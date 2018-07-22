//
//  PhotoInfoPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoPresenter: PhotoInfoPresenterProtocol {
    
    
    var view: PhotoInfoViewProtocol!
    var route: PhotoInfoWireFrameProtocol!
    var interactor: PhotoInfoInteractorInputProtocol!
    
    func viewDidLoad(_ photo: Photo?) {
        interactor.retrievePhotoImage(forPhoto: photo!)
        
    }
    
    func goToTagsView(_ photo: Photo?) {
        route.presentTags(from: view!, photo: photo!, store: interactor!.store!)
    }
}

extension PhotoInfoPresenter: PhotoInfoInteractorOutputProtocol {
    
    func didRetrievePhotoImage(_ photo: Photo) {
        view.showPhotoInfo(forPhoto: photo.title, forImage: photo.image!)
    }
}
