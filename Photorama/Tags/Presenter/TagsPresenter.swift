//
//  TagsPresenter.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

class TagsPresenter: TagsPresenterProtocol {
    
    var view: TagsViewProtocol?
    var route: TagsWireFrameProtocol?
    var interactor: TagsInteractorProtocol?
    
    var photo: Photo!
    var selectedIndexPaths = [NSIndexPath]()
    var tags: [NSManagedObject] = []
    
    func viewDidLoad() {
        updateTags()
    }
    
    func updateTags() {
        let tags = try! interactor!.store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        self.tags = tags
        for tag in photo.tags {
            if let index = tags.index(of:tag) {
                let indexPath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }
    
    func getTagByIndex(index: IndexPath) -> NSManagedObject {
        return tags[index.row]
    }
    
    func getTagsAmount() -> Int {
        return tags.count
    }
    
    func dismissTags() {
        route?.dismissTags(from: view! as! UIViewController)
    }
}
