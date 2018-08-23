//
//  PhotoramaUITests.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 12/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class TagsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    let NEW_TAG = "new_tag"
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddNewTag() {
        let cell = app.tables["PhotosTable"].cells["PhotosTableCell_0"]
        cell.tap()
        app.toolbars["Toolbar"].buttons["Etiquetas"].tap()
        app.navigationBars["Photorama.TagsView"].buttons["Añadir"].tap()
        app.alerts["Añadir Tag"].collectionViews.textFields["tagTextField"].tap()
        app.alerts["Añadir Tag"].collectionViews.textFields["tagTextField"].typeText(NEW_TAG)
        app.alerts["Añadir Tag"].buttons["Guardar"].tap()
        
        XCTAssertTrue(app.tables.staticTexts[NEW_TAG].exists)
        privateTestCheckATagInTagsList()
        privateTestUncheckATagInTagsList()
    }
    
    func privateTestCheckATagInTagsList() {
        app.tables.staticTexts[NEW_TAG].tap()
        XCTAssertTrue(app.tables.staticTexts[NEW_TAG].isEnabled)
    }
    
    func privateTestUncheckATagInTagsList() {
        app.tables.staticTexts[NEW_TAG].tap()
        XCTAssertFalse(app.tables.staticTexts[NEW_TAG].isEnabled)
    }
    
    
}
