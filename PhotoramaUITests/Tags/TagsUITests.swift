//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class TagsUITests: XCTestCase {
    
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    var photoInfoPageObject: PhotoInfoPageObject!
    var tagsPageObject: TagsPageObject!
    
    let NEW_TAG = "new_tag"
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
        self.photosTablePageObject = PhotosTablePageObject(forApp: app)
        self.photoInfoPageObject = PhotoInfoPageObject(forApp: app)
        self.tagsPageObject = TagsPageObject(forApp: app)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddNewTag() {
        photosTablePageObject.tapCell(byPosition: 0)
        photoInfoPageObject.tapTagsButton()
        tagsPageObject.tapAddButton()
                      .tapTagTextField()
                      .tagTextFieldTypeNewTag(newTag: NEW_TAG)
                      .tapSaveButton()
        
        XCTAssertTrue(tagsPageObject.isStaticText(byNAme: NEW_TAG))
        privateTestCheckATagInTagsList()
        privateTestUncheckATagInTagsList()
    }
    
    func privateTestCheckATagInTagsList() {
        tagsPageObject.tapStaticText(byNAme: NEW_TAG)
        XCTAssertTrue(tagsPageObject.isMoreInformationButton())
    }
    
    func privateTestUncheckATagInTagsList() {
        tagsPageObject.tapStaticText(byNAme: NEW_TAG)
        XCTAssertFalse(tagsPageObject.isMoreInformationButton())
    }
    
    
}
