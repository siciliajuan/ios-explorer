//
//  PhotosView.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosView: UIViewController {
    
    var presenter: PhotosPresenterProtocol?
    
    var contentView: PhotosCollectionViewInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad()
    }
    
    func prepareContentView() {
        contentView = PhotosCollectionView(frame: self.view.frame, view: self)
        self.view.addSubview(contentView as! UIView)
    }
}

extension PhotosView: PhotosViewProtocol {
    
    func setPhotos(_ photos: [Photo]) {
        contentView?.setPhotos(photos)
    }
    
    func updateImageForPhoto (_ photo: Photo) {
        contentView?.updateImageForPhoto(photo)
    }
    
}

extension PhotosView: PhotosCollectionViewOutputProtocol {
    func getPhotoForCell(_ photo: Photo) {
        presenter?.getPhotoForCell(photo)
    }
    
    func goToPhotoInfoView(_ photo: Photo) {
        presenter?.goToPhotoInfoView(photo)
    }
}
