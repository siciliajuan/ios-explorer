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
    
    
    // this should go in the wireframe
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ShowTags" {
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = presenter?.interactor?.store
            tagController.photo = presenter?.photo
        }
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo(forPhoto title: String, forImage image: UIImage) {
        navigationItem.title = title
        imageView.image = image
    }
}
