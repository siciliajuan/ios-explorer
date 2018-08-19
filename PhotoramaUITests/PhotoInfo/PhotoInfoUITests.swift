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
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotoNameSelectedInPhotosTableIsTheSameInPhotoInfo() {
        let cell = app.tables["PhotosTable"].cells["PhotosTableCell_0"]
        let photoName = cell.label.components(separatedBy: ", ")[0]
        cell.tap()
        XCTAssertTrue(app.navigationBars[photoName].exists)
        
    }
    
}
