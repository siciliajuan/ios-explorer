//
//  PhotoInfoWireFrame.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit



class PhotoInfoRoute: PhotoInfoWireFrameProtocol {
    
    // separate en constructor and navigator
    class func createPhotoInfoModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PhotoInfoController")
        guard let view = viewController as? PhotoInfoView else {
            return UIViewController()
        }
        var presenter: PhotoInfoPresenterProtocol = PhotoInfoPresenter()
        let wireFrame: PhotoInfoWireFrameProtocol = PhotoInfoRoute()
        var interactor: PhotoInfoInteractorProtocol = PhotoInfoInteractor()
        interactor.store = photoStore
        presenter.view = view
        presenter.photo = photo
        presenter.interactor = interactor
        presenter.route = wireFrame
        view.presenter = presenter
        return view
    }
    
    func presentTags(from view: UIViewController, photo: Photo, store: PhotoStore) {
        let tagsViewController = TagsRoute.createTagsModule(forPhoto: photo, forPhotoStore: store)
        
        if let sourceView = view as? UIViewController {
            sourceView.present(tagsViewController, animated: true)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
