//
//  PhotoInfoProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 8/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation


protocol PhotoInfoViewProtocol {
    var presenter: PhotoInfoPresenterProtocol? { get set }
    func showPhotoInfo()
}

protocol PhotoInfoPresenterProtocol {
    var view: PhotoInfoViewProtocol? { get set }
    var wireFrame: PhotoInfoWireFrameProtocol? { get set }
    var photo: Photo? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol PhotoInfoWireFrameProtocol {
    
}
