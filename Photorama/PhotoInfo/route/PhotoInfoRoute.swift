//
//  PhotoInfoWireFrame.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit



class PhotoInfoRoute: PhotoInfoWireFrameProtocol {
    
    // separate en constructor and navegator
    class func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PhotoInfoController")
        guard let view = viewController as? PhotoInfoView else {
            return UIViewController()
        }
        var presenter: PhotoInfoPresenterProtocol = PhotoInfoPresenter()
        let wireFrame: PhotoInfoWireFrameProtocol = PhotoInfoRoute()
        var interactor: PhotoInfoInteractorProtocol = PhotoInfoInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.photo = photo
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.store = photoStore
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
