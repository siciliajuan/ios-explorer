//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoView: UIViewController {
    
    var contentView: PhotoInfoMainViewInputProtocol?
    
    var photo: Photo?
    
    var presenter: PhotoInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad(photo!)
    }
    
    func prepareContentView() {
        contentView = PhotoInfoMainView(frame: self.view.frame, view: self)
        self.view.addSubview(contentView as! UIView)
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        contentView?.setPhotoImage(image)
    }
}

extension PhotoInfoView: PhotoInfoMainViewOutputProtocol {
    func showTags() {
        presenter?.goToTagsView(photo!)
    }
}
