//
//  PhotosView.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosView: UIViewController {
    
    var presenter: PhotosPresenterProtocol!
    
    @IBOutlet var table: UITableView! {
        didSet {
            table.delegate = self
            table.dataSource = self
            table.register(PhotosTableCellView.self, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    let cellIdentifier = "UITableViewCell"
    var photos = [Photo]()
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
}

extension PhotosView: PhotosViewProtocol {
    
    func setPhotos(_ photos: [Photo]) {
        self.photos = photos
        table.reloadData()
    }
    
    func updateImage(forPhoto photo: Photo) {
        guard
            let photoIndex = self.photos.index(of: photo),
            let cell = table.cellForRow(at: NSIndexPath(row: photoIndex, section: 0) as IndexPath) as? PhotosTableCellView else{
                return
        }
        cell.updateWithImage(image: photo.image)
    }
}
