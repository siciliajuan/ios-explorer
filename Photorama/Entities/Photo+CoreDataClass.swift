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

@objc(Photo)
public class Photo: NSManagedObject {
    var image: UIImage?
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        title = ""
        photoID = ""
        remoteURL = NSURL() as URL
        photoKey = UUID().uuidString
        dateTaken = Date()
    }
    
    func addTagObject(tag: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.add(tag)
    }
    
    func removeTagObject(tag: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.remove(tag)
    }
}
