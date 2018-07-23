//
//  PhotosRoute.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosRouter: PhotosWireFrameProtocol {
    
    class func createPhotosModule(forPhotoStore store: PhotoStore) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PhotosController")
        guard let view = navController.childViewControllers.first as? PhotosView else {
            fatalError("Imposible to create navController to load PhotosController")
        }
        var presenter: PhotosPresenterProtocol & PhotosInteractorOutputProtocol = PhotosPresenter()
        let route: PhotosWireFrameProtocol = PhotosRouter()
        var interactor: PhotosInteractorInputProtocol = PhotosInteractor()
        interactor.store = store
        presenter.interactor = interactor
        presenter.route = route
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        return navController
    }
    
    func presentPhotoInfo(from view: PhotosViewProtocol, photo: Photo, store: PhotoStore) {
        let PhotoInfoViewController = PhotoInfoRouter.createPhotoInfoModule(forPhoto: photo, forPhotoStore: store)
        guard let sourceView = view as? UIViewController else {
                fatalError("Imposible to create viewControoler to load PhotoInfoViewController")
        }
        sourceView.navigationController?.pushViewController(PhotoInfoViewController, animated: true)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
