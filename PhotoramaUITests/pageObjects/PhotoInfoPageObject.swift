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
    private lazy var tagsButton = buttons["Etiquetas"]
    private lazy var navigationBars = findAll(.navigationBar)
    private lazy var buttons = findAll(.button)
    
    init(forApp app: XCUIApplication) {
        self.app = app
    }
    
    func getNavigationBar(byName name: String) -> XCUIElement {
        return navigationBars[name]
    }
    
    func tapTagsButton() {
        tagsButton.tap()
    }
}
