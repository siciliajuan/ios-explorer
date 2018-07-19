//
//  PhotosRepositoryProtocol.swift
//  Photorama
//
//  Created by juan sicilia on 19/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

protocol PhotosRepositoryProtocol {
    func fetchLastUploadedFlickerPhotos(completion: @escaping () -> Void)
    func getAllPersistedPhotos() throws -> [Photo]
}
