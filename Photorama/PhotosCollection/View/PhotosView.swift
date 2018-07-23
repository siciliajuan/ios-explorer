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
    
    @IBOutlet var table: UITableView!
    
    let cellIdentifier = "UITableViewCell"
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter.viewDidLoad()
    }
    
    func prepareContentView() {
        Bundle.main.loadNibNamed("PhotosMainView", owner: self, options: nil)
        self.table.frame = self.view.bounds
        table.delegate = self
        table.dataSource = self
        table.register(PhotosTableCellView.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(table)
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

extension PhotosView: UITableViewDelegate, UITableViewDataSource {
    
    
    // Delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        presenter.getImageCell(forPhoto: photo)
    }
    
    func tableView(_ UITableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        presenter.didShowPhotoInfoView(forPhoto: photo)
    }
    
    // DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotosTableCellView
        cell.photo = photos[indexPath.row]
        return cell
    }
}
