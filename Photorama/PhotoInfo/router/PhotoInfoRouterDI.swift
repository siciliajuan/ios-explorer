//
//  PhotosRouteDIHelper.swift
//  Photorama
//
//  Created by juan sicilia on 7/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Swinject
import Foundation

struct PhotoInfoRouterDI: RouterDIProtrocol {
    
    static func preparePhotoStore(forContainer container: Container) {
        
        container.register(ImageWebData.self) { _ in ImageWebData() }
        container.register(ImageFileData.self) { _ in ImageFileData() }
        container.register(ImageCacheData.self) { _ in ImageCacheData() }
        container.register(ImageRepository.self) { r in
            let imageRepository = ImageRepository()
            imageRepository.imageCache = r.resolve(ImageCacheData.self)!
            imageRepository.imageFS = r.resolve(ImageFileData.self)!
            imageRepository.imageWebData = r.resolve(ImageWebData.self)!
            return imageRepository
        }
        
        container.register(PhotoStore.self) { r in
            let photoStore = PhotoStore()
            photoStore.imageRepository = r.resolve(ImageRepository.self)
            return photoStore
        }
    }
}
