
//
//  PhotosCollectionViewInputProtocol.swift
//  Photorama
//
//  Created by juan sicilia on 12/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

// PhotosView -> PhotosCollectionView
protocol PhotosCollectionViewInputProtocol {
    func setPhotos(_ photos: [Photo])
    func updateImageForPhoto (_ photo: Photo)
}

// PhotosCollectionView -> PhotosView
protocol PhotosCollectionViewOutputProtocol {
    func getPhotoForCell(_ photo: Photo)
    func goToPhotoInfoView(_ photo: Photo)
}
