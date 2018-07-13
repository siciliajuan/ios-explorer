//
//  TagsViewMainView.swift
//  Photorama
//
//  Created by juan sicilia on 13/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import CoreData

protocol TagsViewMainViewInputProtocol {
    func reloadSections()
    func updateTags()
    func setTags(_ tags: [NSManagedObject])
}

protocol TagsViewMainViewOutputProtocol {
    func removePhotoTag(_ tag: NSManagedObject)
    func addPhotoTag(_ tag: NSManagedObject)
    func commitPersistentData()
}
