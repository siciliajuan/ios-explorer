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
            let tagsCoreData = TagsCoreData()
            tagsCoreData.coreDataStack = r.resolve(CoreDataStack.self)
            return tagsCoreData
        }
        container.register(TagsRepository.self) { r in
            let tagsRepository = TagsRepository()
            tagsRepository.tagsCoreData = r.resolve(TagsCoreData.self)!
            return tagsRepository
        }
        
        container.register(PhotosCoreData.self) { r in
            let photosCoreData = PhotosCoreData()
            photosCoreData.coreDataStack = r.resolve(CoreDataStack.self)
            return photosCoreData
        }
        container.register(PhotosWebData.self) { _ in PhotosWebData() }
        container.register(PhotosRepository.self) { r in
            let photosRepository = PhotosRepository()
            photosRepository.photosCoreData = r.resolve(PhotosCoreData.self)!
            photosRepository.photosWebData = r.resolve(PhotosWebData.self)!
            return photosRepository
        }
        
        container.register(PhotoStore.self) { r in
            let photoStore = PhotoStore()
            photoStore.photosRepository = r.resolve(PhotosRepository.self)
            photoStore.tagsRepository = r.resolve(TagsRepository.self)
            return photoStore
        }
    }
}
