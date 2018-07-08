//
//  PhotoInfoWireFrame.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit



class PhotoInfoWireFrame: PhotoInfoWireFrameProtocol {
    
    class func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PhotoInfoController")
        if let view = viewController as? PhotoInfoView {
            var presenter: PhotoInfoPresenterProtocol = PhotoInfoPresenter()
            let wireFrame: PhotoInfoWireFrameProtocol = PhotoInfoWireFrame()
            view.presenter = presenter
            presenter.view = view
            presenter.photo = photo
            presenter.store = photoStore
            presenter.wireFrame = wireFrame
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
