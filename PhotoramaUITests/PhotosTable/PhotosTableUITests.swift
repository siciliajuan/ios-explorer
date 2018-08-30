//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class PhotosTableUITests: XCTestCase {
    
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
        self.photosTablePageObject = PhotosTablePageObject(forApp: app)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotosTableIsLoaded() {
        XCTAssertTrue(photosTablePageObject.tableOnScreen().exists)
    }
    
}