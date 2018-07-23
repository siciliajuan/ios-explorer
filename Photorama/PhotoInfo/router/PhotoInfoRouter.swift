//
//  PhotoInfoWireFrame.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit



class PhotoInfoRouter: PhotoInfoWireFrameProtocol {
    
    // separate en constructor and navigator
    class func createPhotoInfoModuleVC(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PhotoInfoController")
        guard let view = viewController as? PhotoInfoView else {
            fatalError("Imposible to create viewController to load PhotoInfoController")
        }
        var presenter: PhotoInfoPresenterProtocol & PhotoInfoInteractorOutputProtocol = PhotoInfoPresenter()
        let wireFrame: PhotoInfoWireFrameProtocol = PhotoInfoRouter()
        var interactor: PhotoInfoInteractorInputProtocol = PhotoInfoInteractor()
        interactor.store = photoStore
        presenter.view = view
        presenter.interactor = interactor
        presenter.route = wireFrame
        interactor.presenter = presenter
        view.presenter = presenter
        view.photo = photo
        return view
    }
    
    func presentTagsVC(from view: PhotoInfoViewProtocol, photo: Photo, store: PhotoStore) {
        let tagsViewController = TagsRouter.createTagsModuleVC(forPhoto: photo, forPhotoStore: store)
        guard let sourceView = view as? UIViewController else {
                fatalError("Imposible to create viewController to load tagsViewController")
        }
        sourceView.present(tagsViewController, animated: true)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
