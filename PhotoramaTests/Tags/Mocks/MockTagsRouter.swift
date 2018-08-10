//
//  MockTagsRouter.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 8/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation
import UIKit

class MockTagsRouter: TagsWireFrameProtocol {
    
    var dismissTagsVCCalled = false
    
    static func createTagsModuleVC(forPhoto photo: Photo) -> UIViewController {
        return UIViewController()
    }
    
    func dismissTagsVC(from: TagsViewProtocol) {
        dismissTagsVCCalled = true
    }
}
