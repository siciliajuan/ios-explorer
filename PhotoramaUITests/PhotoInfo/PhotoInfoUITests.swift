//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class PhotoInfoUITests: BaseTestCase {
    
    func testPhotoNameSelectedInPhotosTableIsTheSameInPhotoInfo() {
        let photoName = photosTablePageObject.cellName(byPosition: 0)
        let photoInfoPageObject = photosTablePageObject.tapCell(byPosition: 0)
        XCTAssertTrue(photoInfoPageObject.getNavigationBar(byName: photoName).exists)
        
    }
    
}
