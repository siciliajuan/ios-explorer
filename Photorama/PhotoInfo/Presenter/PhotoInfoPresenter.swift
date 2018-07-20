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
    
    func viewDidLoad(_ photo: PhotoTO?) {
        interactor.retrievePhotoImage(forPhoto: photo!)
        
    }
    
    func goToTagsView(_ photo: PhotoTO?) {
        route.presentTags(from: view!, photo: photo!, store: interactor!.store!)
    }
}

extension PhotoInfoPresenter: PhotoInfoInteractorOutputProtocol {
    
    func didRetrievePhotoImage(_ photo: PhotoTO) {
        view.showPhotoInfo(forPhoto: photo.title, forImage: photo.image!)
    }
}
