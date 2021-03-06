//
//  TagsPAgeObject.swift
//  PhotoramaUITests
//
//  Created by juan sicilia on 30/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import XCTest

class TagsPageObject: BaseScreen {
    
    var app: XCUIApplication!
    
    private lazy var tagTextField = textFields["tagTextField"]
    private lazy var addButton = buttons["Añadir"].firstMatch
    private lazy var moreInformationButton = buttons["Más información"]
    private lazy var saveButton = buttons["Guardar"]
    private lazy var buttons = findAll(.button)
    private lazy var textFields = findAll(.textField)
    private lazy var staticTexts = findAll(.staticText)
    
    func tapAddButton() -> TagsPageObject {
        addButton.tap()
        return self
    }
    
    @discardableResult
    func tapSaveButton() -> TagsPageObject {
        saveButton.tap()
        return self
    }
    
    func tapTagTextField() -> TagsPageObject {
        tagTextField.tap()
        return self
    }
    
    func tagTextFieldTypeNewTag(newTag: String) -> TagsPageObject {
        tagTextField.typeText(newTag)
        return self
    }
    
    func isMoreInformationButton() -> Bool {
        return moreInformationButton.exists
    }
    
    func tapStaticText(byNAme name: String) -> TagsPageObject {
        staticTexts[name].tap()
        return self
    }
    
    func isStaticText(byNAme name: String) -> Bool {
        return staticTexts[name].exists
    }
}
