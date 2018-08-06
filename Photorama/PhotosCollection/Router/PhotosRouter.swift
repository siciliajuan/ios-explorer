//
//  PhotosRoute.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosRouter: PhotosWireFrameProtocol {
    
    class func createPhotosModuleVC() -> UIViewController {
        
        // prepare dataSource
        let coreDataStack = CoreDataStack()
        let photoStore = PhotoStore()
        let photosRepository = PhotosRepository()
        let imageRepository = ImageRepository()
        imageRepository.imageCache = ImageCacheData()
        imageRepository.imageFS = ImageFileData()
        imageRepository.imageWebData = ImageWebData()
        let photosCoreData = PhotosCoreData()
        photosCoreData.coreDataStack = coreDataStack
        photosRepository.photosCoreData = photosCoreData
        photosRepository.photosWebData = PhotosWebData()
        photoStore.photosRepository = photosRepository
        photoStore.imageRepository = imageRepository
        
        let view = PhotosView.init(nibName: String(describing: PhotosView.self), bundle: Bundle.main)
        var presenter: PhotosPresenterProtocol & PhotosInteractorOutputProtocol = PhotosPresenter()
        let route: PhotosWireFrameProtocol = PhotosRouter()
        var interactor: PhotosInteractorInputProtocol = PhotosInteractor()
        interactor.store = photoStore
        presenter.interactor = interactor
        presenter.route = route
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        let navController = UINavigationController()
        navController.pushViewController(view, animated: true)
        return navController
    }
    
    func presentPhotoInfoVC(from view: PhotosViewProtocol, photo: Photo, store: PhotoStore) {
        let PhotoInfoViewController = PhotoInfoRouter.createPhotoInfoModuleVC(forPhoto: photo)
        guard let sourceView = view as? UIViewController else {
                fatalError("Imposible to create viewControoler to load PhotoInfoViewController")
        }
        sourceView.navigationController?.pushViewController(PhotoInfoViewController, animated: true)
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
