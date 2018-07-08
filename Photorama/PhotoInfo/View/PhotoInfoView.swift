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
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove thees lines when everything is load by wireframe
        presenter = PhotoInfoPresenter()
        presenter?.view = self
        
        presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ShowTags" {
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = store
            tagController.photo = photo
        }
    }
}

extension PhotoInfoView: PhotoInfoViewProtocol {
    
    func showPhotoInfo() {
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
