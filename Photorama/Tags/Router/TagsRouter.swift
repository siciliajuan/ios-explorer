//
//  TagsRoute.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsRouter: TagsWireFrameProtocol {
    
    class func createTagsModuleVC(forPhoto photo: Photo, forPhotoStore photoStore: PhotoStore) -> UIViewController {
        
        
        
        // prepare dataSource
        let coreDataStack = CoreDataStack()
        let photoStore = PhotoStore()
        let photosRepository = PhotosRepository()
        let tagsRepository = TagsRepository()
        let tagsCoreData = TagsCoreData()
        tagsCoreData.coreDataStack = coreDataStack
        tagsRepository.tagsCoreData = tagsCoreData
        let photosCoreData = PhotosCoreData()
        photosCoreData.coreDataStack = coreDataStack
        photosRepository.photosCoreData = photosCoreData
        photosRepository.photosWebData = PhotosWebData()
        photoStore.photosRepository = photosRepository
        photoStore.tagsRepository = tagsRepository
        
        let view = TagsView.init(nibName: String(describing: TagsView.self), bundle: Bundle.main)
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
        let navController = UINavigationController()
        navController.pushViewController(view, animated: true)
        return navController
    }
    
    func dismissTagsVC(from view: TagsViewProtocol) {
        guard let sourceView = view as? UIViewController else {
            fatalError("Imposible to navigate back to photosInfoController")
        }
        sourceView.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }}
