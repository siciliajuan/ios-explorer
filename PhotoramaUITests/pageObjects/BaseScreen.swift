//
//  BaseScreen.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 30/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

protocol BaseScreen {
    var app: XCUIApplication! {get}
}

extension BaseScreen {
    
    init(forApp app: XCUIApplication) {
        self.app = app
    }
    
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return app.descendants(matching: type)
    }
}
