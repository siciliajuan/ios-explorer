//
//  BaseTestCase.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 9/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

class  BaseTestCase: XCTestCase {
    
    var app: XCUIApplication!
    var photosTablePageObject: PhotosTablePageObject!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
        continueAfterFailure = false
        photosTablePageObject = PhotosTablePageObject(forApp: app)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
