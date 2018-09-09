//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class PhotosTableUITests: XCTestCase, BaseTestCase {
        
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        prepareTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotosTableIsLoaded() {
        XCTAssertTrue(photosTablePageObject.tableOnScreen().exists)
    }
    
}
