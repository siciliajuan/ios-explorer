//
//  TagsRoute.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsRouter: TagsWireFrameProtocol {
    
    class func createTagsModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "TagsNavigationController")
        guard let view = navController.childViewControllers.first as? TagsView else {
            fatalError("Imposible to create navController to load TagsNavigationController")
        }
        var presenter: TagsPresenterProtocol & TagsInteractorOutputProtocol = TagsPresenter()
        let route: TagsWireFrameProtocol = TagsRouter()
        var interactor: TagsInteractorInputProtocol = TagsInteractor()
        interactor.store = photoStore
        presenter.interactor = interactor
        presenter.route = route
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        view.photo = photo
        return navController
    }
    
    func dismissTags(from view: TagsViewProtocol) {
        guard let sourceView = view as? UIViewController else {
            fatalError("Imposible to navigate back to photosInfoController")
        }
        sourceView.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }}
