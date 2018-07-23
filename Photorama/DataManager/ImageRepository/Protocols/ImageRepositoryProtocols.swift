//
//  ImageDataProtocol.swift
//  Photorama
//
//  Created by juan sicilia on 16/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

protocol ImageRepositoryProtocol {
    func getImage(forPhoto photo: Photo, completion: @escaping (ImageResult) -> Void)
}
