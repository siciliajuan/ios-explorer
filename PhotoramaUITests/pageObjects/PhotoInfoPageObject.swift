//
//  PhotosInfoPageObject.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 30/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

class PhotoInfoPageObject: BaseScreen {

    var app: XCUIApplication!
    var tagsPageObject: TagsPageObject!
    
    private lazy var tagsButton = buttons["Etiquetas"]
    private lazy var navigationBars = findAll(.navigationBar)
    private lazy var buttons = findAll(.button)
    
    init(forApp app: XCUIApplication) {
        self.app = app
        self.tagsPageObject = TagsPageObject(forApp: app)
    }
    
    func getNavigationBar(byName name: String) -> XCUIElement {
        return navigationBars[name]
    }
    
    func tapTagsButton() -> TagsPageObject {
        tagsButton.tap()
        return tagsPageObject
    }
}
