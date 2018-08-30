//
//  PhotosTablePAgeObject.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 30/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

class PhotosTablePageObject: BaseScreen {
    
    var app: XCUIApplication!
    
    private lazy var cells = table.cells
    private lazy var table = tables["PhotosTable"]
    private lazy var tables = findAll(.table)
    
    init(forApp app: XCUIApplication) {
        self.app = app
    }
    
    func tableOnScreen() -> XCUIElement {
        return table
    }
    
    func cellName(byPosition position: Int) -> String {
        let cell = getCell(byPosition: position)
        let photoName = cell.label.components(separatedBy: ", ")[0]
        return photoName
    }
    
    func tapCell(byPosition position: Int) {
        let cell = getCell(byPosition: position)
        cell.tap()
    }
    
    private func getCell(byPosition position: Int) -> XCUIElement {
        return cells["PhotosTableCell_\(position)"]
    }
    
}
