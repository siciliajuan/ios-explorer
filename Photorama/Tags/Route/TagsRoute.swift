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
        let wireFrame: TagsWireFrameProtocol = TagsRoute()
        var interactor: TagsInteractorProtocol = TagsInteractor()
        view.photo = photo
        view.store = photoStore
        return navController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }}