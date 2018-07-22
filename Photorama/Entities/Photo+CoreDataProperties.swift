//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoMO> {
        return NSFetchRequest<PhotoMO>(entityName: "PhotoMO")
    }

    @NSManaged public var dateTaken: Date
    @NSManaged public var photoID: String
    @NSManaged public var photoKey: String
    @NSManaged public var remoteURL: URL
    @NSManaged public var title: String
    @NSManaged public var tagsMO: Set<NSManagedObject>

}
