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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ShowTags" {
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = presenter?.store
            tagController.photo = presenter?.photo
        }
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo(forPhoto photo: Photo, forPhotoStore store: PhotoStore) {
        navigationItem.title = photo.title
        store.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                OperationQueue.main.addOperation{
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
