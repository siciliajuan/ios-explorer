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
            table.register(UINib(nibName: String(describing: PhotosTableCellView.self), bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    let cellIdentifier = "UITableViewCell"
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.isAccessibilityElement = true
        table.isAccessibilityElement = true
        table.accessibilityIdentifier = "PhotosTable"
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
            let cell = table.cellForRow(at: IndexPath(row: photoIndex, section: 0)) as? PhotosTableCellView else{
                return
        }
        cell.updateWithImage(image: photo.image)
    }
}
