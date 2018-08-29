//
//  PhotosRouteDIHelper.swift
//  Photorama
//
//  Created by juan sicilia on 7/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Swinject
import Foundation

struct TagsRouterDI: RouterDIProtrocol {
    
    static func preparePhotoStore(forContainer container: Container) {
        
        container.register(CoreDataStack.self) { _ in CoreDataStack() }
        
        container.register(TagsCoreData.self) { r in
            return TagsCoreData(coreDataStack: r.resolve(CoreDataStack.self)!)
        }
        container.register(TagsRepository.self) { r in
            return TagsRepository(tagsCoreData: r.resolve(TagsCoreData.self)!)
        }
        
        container.register(PhotosCoreData.self) { r in
            return PhotosCoreData(coreDataStack: r.resolve(CoreDataStack.self)!)
        }
        container.register(PhotosWebData.self) { _ in PhotosWebData() }
        container.register(PhotosRepository.self) { r in
            return PhotosRepository(photosCoreData: r.resolve(PhotosCoreData.self)!, photosWebData: r.resolve(PhotosWebData.self)!)
        }
        
        container.register(PhotoStore.self) { r in
            let photoStore = PhotoStore(imageRepository: nil, tagsRepository: r.resolve(TagsRepository.self), photosRepository: r.resolve(PhotosRepository.self))
            return photoStore
        }
    }
}
