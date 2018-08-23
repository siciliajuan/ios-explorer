//
//  TagsCoreDataTests.swift
//  TagsCoreDataTests
//
//  Created by juan sicilia on 6/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest
import CoreData

class TagsCoreDataTests: XCTestCase {
    
    var tagsCoreData: TagsCoreData = TagsCoreData()
    var mockcoreDataStack: MockcoreDataStack = MockcoreDataStack()
    
    // for test purpose
    let initialTags = ["a_tag_one","c_tag_three","b_tag_two","e_tag_five","d_tag_four"]
    let tagsAlphabeticalOrder = [0,2,1,4,3]
    
    override func setUp() {
        super.setUp()
        tagsCoreData.coreDataStack = mockcoreDataStack
        initStubs()
    }
    
    override func tearDown() {
        flushData()
        super.tearDown()
    }
    
    func testGetTagsSortedByName() {
        let tags = try! tagsCoreData.getTagsSortedByName()
        XCTAssertEqual(tags.count, 5, "Error wrong tags amount")
        tags.enumerated().forEach { (index, element) in
             XCTAssertEqual(element, initialTags[tagsAlphabeticalOrder[index]], "wrong tags order")
        }
    }
    
    func testGetTagsSortedByNameWithNewTagInsertedFirstPosition() {
        let newTag = "1_la_primera"
        tagsCoreData.saveTag(newTag)
        let tags = try! tagsCoreData.getTagsSortedByName()
        XCTAssertEqual(tags.count, 6, "Error wrong tags amount")
        tags.enumerated().forEach { (index, element) in
            print(element)
            if index == 0 {
                XCTAssertEqual(element, newTag, "wrong tags order")
            } else {
                XCTAssertEqual(element, initialTags[tagsAlphabeticalOrder[index - 1]], "wrong tags order")
            }
        }
    }
    
    func testGetTagsSortedByNameWithNewTagInsertedLastPosition() {
        let newTag = "z_la_primera"
        tagsCoreData.saveTag(newTag)
        let tags = try! tagsCoreData.getTagsSortedByName()
        XCTAssertEqual(tags.count, 6, "Error wrong tags amount")
        tags.enumerated().forEach { (index, element) in
            print(element)
            if index == 5 {
                XCTAssertEqual(element, newTag, "wrong tags order")
            } else {
                XCTAssertEqual(element, initialTags[tagsAlphabeticalOrder[index]], "wrong tags order")
            }
        }
    }
    
    func initStubs() {
        let context = mockcoreDataStack.getNewManagedObjectContext()!
        func insertTag(_ tagName: String) {
            let newTag = NSEntityDescription.insertNewObject(forEntityName: "TagMO", into: context)
            newTag.setValue(tagName, forKey: "name")
        }
        initialTags.forEach{insertTag($0)}
        mockcoreDataStack.saveChanges(context: context)
    }
    
    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "TagMO")
        let context = mockcoreDataStack.getNewManagedObjectContext()!
        let objs = try! context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            context.delete(obj)
        }
        mockcoreDataStack.saveChanges(context: context)
    }
    
}
