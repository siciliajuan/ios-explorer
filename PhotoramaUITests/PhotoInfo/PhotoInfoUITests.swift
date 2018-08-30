//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class PhotoInfoUITests: XCTestCase {
    
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    var photoInfoPageObject: PhotoInfoPageObject!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
        self.photosTablePageObject = PhotosTablePageObject(forApp: app)
        self.photoInfoPageObject = PhotoInfoPageObject(forApp: app)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotoNameSelectedInPhotosTableIsTheSameInPhotoInfo() {
        let photoName = photosTablePageObject.cellName(byPosition: 0)
        photosTablePageObject.tapCell(byPosition: 0)
        XCTAssertTrue(photoInfoPageObject.getNavigationBar(byName: photoName).exists)
        
    }
    
}
