//
//  WebServicesHelper.swift
//  Photorama
//
//  Created by juan sicilia on 17/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class WebServicesHelper {
    
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
}
