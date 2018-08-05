//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoView: UIViewController {
    
    var presenter: PhotoInfoPresenterProtocol!
    var photo: Photo! {
        didSet {
            presenter.photoDidSet(photo)
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func showTags() {
        presenter.didShowTags(forPhoto: photo)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        imageView.image = image
    }
}
