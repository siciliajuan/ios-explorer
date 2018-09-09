//
//  BaseTestCase.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 9/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

protocol BaseTestCase: class {
    
    var app: XCUIApplication! {get set}
    var photosTablePageObject: PhotosTablePageObject! {get set}
    
}

extension BaseTestCase {

    func prepareTest() {
        app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
        photosTablePageObject = PhotosTablePageObject(forApp: app)
    }
    
}
