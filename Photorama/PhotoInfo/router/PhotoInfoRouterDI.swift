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
            return ImageRepository(imageCache: r.resolve(ImageCacheData.self)!, imageFS: r.resolve(ImageFileData.self)!, imageWebData: r.resolve(ImageWebData.self)!)
        }
        
        container.register(PhotoStore.self) { r in
            let photoStore = PhotoStore(imageRepository: r.resolve(ImageRepository.self), tagsRepository: nil, photosRepository: nil)
            return photoStore
        }
    }
}
