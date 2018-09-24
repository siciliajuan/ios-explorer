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
    
    
    func tableOnScreen() -> XCUIElement {
        return table
    }
    
    func cellName(byPosition position: Int) -> String {
        let cell = getCell(byPosition: position)
        let photoName = cell.label.components(separatedBy: ", ")[0]
        return photoName
    }
    
    @discardableResult
    func tapCell(byPosition position: Int) -> PhotoInfoPageObject {
        let cell = getCell(byPosition: position)
        cell.tap()
        return PhotoInfoPageObject(forApp: app)
    }
    
    private func getCell(byPosition position: Int) -> XCUIElement {
        return cells["PhotosTableCell_\(position)"]
    }
    
}
