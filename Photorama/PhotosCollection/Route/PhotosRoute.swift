//
//  PhotosRoute.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosRoute: PhotosWireFrameProtocol {
    
    class func createPhotosModule(forPhotoStore store: PhotoStore) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PhotosController")
        guard let view = navController.childViewControllers.first as? PhotosView else {
            return UIViewController()
        }
        var presenter: PhotosPresenterProtocol & PhotosInteractorOutputProtocol = PhotosPresenter()
        let route: PhotosWireFrameProtocol = PhotosRoute()
        var interactor: PhotosInteractorInputProtocol = PhotosInteractor()
        interactor.store = store
        presenter.interactor = interactor
        presenter.route = route
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        // remove this
        view.store = store
        return navController
    }
    
    func presentPhotoInfo(from view: PhotosViewProtocol, photo: Photo, store: PhotoStore) {
        let PhotoInfoViewController = PhotoInfoRoute.createPhotoInfoModule(forPhoto: photo, forPhotoStore: store)
        
        if let sourceView = view as? UIViewController {
            sourceView.present(PhotoInfoViewController, animated: true)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
