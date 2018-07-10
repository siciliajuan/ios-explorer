//
//  PhotoInfoPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoPresenter: PhotoInfoPresenterProtocol {
    
    var view: PhotoInfoViewProtocol?
    var route: PhotoInfoWireFrameProtocol?
    var interactor: PhotoInfoInteractorProtocol?
    var photo: Photo?
    
    func viewDidLoad() {
        photo!.image = interactor?.getPhotoImage(forPhoto: photo!)
        view?.showPhotoInfo(forPhoto: photo!.title, forImage: photo!.image!)
    }
    
    func showTags() {
        route?.presentTags(from: view!, photo: photo!, store: interactor!.store!)
    }
}
