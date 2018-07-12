//
//  PhotoInfoViewsProtocols.swift
//  Photorama
//
//  Created by juan sicilia on 12/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

// PhotoInfoView -> PhotoInfoMainView
protocol PhotoInfoMainViewInputProtocol {
    func setPhotoImage(_ image: UIImage)
}

// PhotoInfoMainView -> PhotoInfoView
protocol PhotoInfoMainViewOutputProtocol {
    func showTags()
}
