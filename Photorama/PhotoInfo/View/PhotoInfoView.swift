//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by juan sicilia on 23/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoView: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo?
    
    var presenter: PhotoInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(photo!)
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    @IBAction func showTags() {
        presenter?.showTags(photo!)
    }
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        imageView.image = image
    }
}
