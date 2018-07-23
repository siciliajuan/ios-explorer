//
//  Photo+CoreDataClass.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//
//

import UIKit
import CoreData

@objc(PhotoMO)
public class PhotoMO: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        title = ""
        photoID = ""
        remoteURL = NSURL() as URL
        photoKey = ""
        dateTaken = Date()
    }
    
    func addTagObject(tagMO: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tagsMO")
        currentTags.add(tagMO)
    }
    
    func removeTagObject(tagMO: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tagsMO")
        currentTags.remove(tagMO)
    }
}
