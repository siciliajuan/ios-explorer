//
//  PhotosView.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosView: UIViewController {
    
    let cellIdentifier = "UICollectionViewCell"
    
    var presenter: PhotosPresenterProtocol?
    
    @IBOutlet var collectionView: UICollectionView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        presenter?.viewDidLoad()
    }
}

extension PhotosView: PhotosViewProtocol {
    
    func setPhotos(_ photos: [Photo]) {
        self.photos = photos
        collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    
    func updateImageForPhoto (_ photo: Photo) {
        let photoIndex = self.photos.index(of: photo)!
        let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
        if let cell = self.collectionView.cellForItem(at: photoIndexPath as IndexPath) as? PhotosViewCell {
            cell.updateWithImage(image: photo.image)
        }
    }
    
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        presenter?.getPhotoForCell(photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        presenter?.goToPhotoInfoView(photo)
    }
    
    // DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotosViewCell
        return cell
    }
}
