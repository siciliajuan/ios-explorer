//
//  TagsRouterTests.swift
//  TagsRouterTests
//
//  Created by juan sicilia on 6/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest
import UIKit

class TagsRouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateTagsModuleVC() {
        let photo = TestHelpers.createGenericPhoto()
        let navVC = TagsRouter.createTagsModuleVC(forPhoto: photo) as! UINavigationController
        XCTAssertTrue(navVC.isKind(of: UINavigationController.self))
        XCTAssertTrue((navVC.viewControllers.first?.isKind(of: TagsView.self))!)
        let tagsCV = navVC.viewControllers.first as! TagsView
        XCTAssertEqual(tagsCV.photo, photo)
    }
}
