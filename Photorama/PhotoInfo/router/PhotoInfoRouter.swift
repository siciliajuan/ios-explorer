//
//  PhotoInfoWireFrame.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import Swinject

class PhotoInfoRouter: PhotoInfoWireFrameProtocol {
    
    // separate en constructor and navigator
    class func createPhotoInfoModuleVC(forPhoto photo: Photo) -> UIViewController {
        
        let container = Container()
        PhotoInfoRouterDI.preparePhotoStore(forContainer: container)
        
        let view = PhotoInfoView.init(nibName: String(describing: PhotoInfoView.self), bundle: Bundle.main)
        var presenter: PhotoInfoPresenterProtocol & PhotoInfoInteractorOutputProtocol = PhotoInfoPresenter()
        let wireFrame: PhotoInfoWireFrameProtocol = PhotoInfoRouter()
        var interactor: PhotoInfoInteractorInputProtocol = PhotoInfoInteractor()
        interactor.store = container.resolve(PhotoStore.self)
        presenter.view = view
        presenter.interactor = interactor
        presenter.route = wireFrame
        interactor.presenter = presenter
        view.presenter = presenter
        view.photo = photo
        return view
    }
    
    func presentTagsVC(from view: PhotoInfoViewProtocol, photo: Photo) {
        let tagsViewController = TagsRouter.createTagsModuleVC(forPhoto: photo)
        guard let sourceView = view as? UIViewController else {
                fatalError("Imposible to create viewController to load tagsViewController")
        }
        sourceView.present(tagsViewController, animated: true)
    }
    
}
