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
    
    var presenter: PhotoInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    @IBAction func showTags() {
        presenter?.showTags()
    }
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        imageView.image = image
    }
}
