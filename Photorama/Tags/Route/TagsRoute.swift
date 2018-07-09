//
//  TagsRoute.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsRoute: TagsWireFrameProtocol {
    
    class func createTagsModule(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "TagsNavigationController")
        guard let view = navController.childViewControllers.first as? TagsView else {
            return UIViewController()
        }
        var presenter: TagsPresenterProtocol = TagsPresenter()
        let route: TagsWireFrameProtocol = TagsRoute()
        var interactor: TagsInteractorProtocol = TagsInteractor()
        interactor.store = photoStore
        presenter.interactor = interactor
        presenter.photo = photo
        presenter.route = route
        presenter.view = view
        view.presenter = presenter
        return navController
    }
    
    func dismissTags(from view: UIViewController) {
        view.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }}
