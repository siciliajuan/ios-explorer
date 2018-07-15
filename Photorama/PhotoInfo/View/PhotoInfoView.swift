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
    @IBOutlet var contentView: UIView!
    
    @IBAction func showTags() {
        presenter?.goToTagsView(photo)
    }
    
    
    var photo: Photo?
    
    var presenter: PhotoInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad(photo!)
    }
    
    func prepareContentView() {
        Bundle.main.loadNibNamed("PhotoInfoMainView", owner: self, options: nil)
        contentView.frame = self.view.bounds
        self.view.addSubview(contentView)
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        imageView.image = image
    }
}
