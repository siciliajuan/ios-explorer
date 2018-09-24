//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class PhotosTableUITests: BaseTestCase {
    
    func testPhotosTableIsLoaded() {
        XCTAssertTrue(photosTablePageObject.tableOnScreen().exists)
    }
    
}
