//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class TagsUITests: XCTestCase, BaseTestCase {
        
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    
    let NEW_TAG = "new_tag"
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        prepareTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddNewTag() {
        let tagsPageObject = photosTablePageObject.tapCell(byPosition: 0)
            .tapTagsButton()
            .tapAddButton()
            .tapTagTextField()
            .tagTextFieldTypeNewTag(newTag: NEW_TAG)
            .tapSaveButton()
        
        XCTAssertTrue(tagsPageObject.isStaticText(byNAme: NEW_TAG))
    }
    
    func privateTestCheckATagInTagsList() {
        let tagsPageObject = photosTablePageObject.tapCell(byPosition: 0)
            .tapTagsButton()
            .tapAddButton()
            .tapTagTextField()
            .tagTextFieldTypeNewTag(newTag: NEW_TAG)
            .tapSaveButton()
            .tapStaticText(byNAme: NEW_TAG)
        
        XCTAssertTrue(tagsPageObject.isMoreInformationButton())
    }
    
    func privateTestUncheckATagInTagsList() {
        let tagsPageObject = photosTablePageObject.tapCell(byPosition: 0)
            .tapTagsButton()
            .tapAddButton()
            .tapTagTextField()
            .tagTextFieldTypeNewTag(newTag: NEW_TAG)
            .tapSaveButton()
            .tapStaticText(byNAme: NEW_TAG)
            .tapStaticText(byNAme: NEW_TAG)
        
        XCTAssertFalse(tagsPageObject.isMoreInformationButton())
    }
    
    
}
