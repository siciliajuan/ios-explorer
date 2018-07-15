//
//  PhotosView.swift
//  Photorama
//
//  Created by juan sicilia on 10/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosView: UIViewController {
    
    var presenter: PhotosPresenterProtocol?
    
    @IBOutlet var collection: UICollectionView!
    
    let cellIdentifier = "UICollectionViewCell"
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad()
    }
    
    func prepareContentView() {
        Bundle.main.loadNibNamed("PhotosMainView", owner: self, options: nil)
        self.collection.frame = self.view.bounds
        collection.delegate = self
        collection.dataSource = self
        collection.register(PhotosCollectionCellView.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(collection)
    }
    
    func getPhotoForCell(_ photo: Photo) {
        presenter?.getPhotoForCell(photo)
    }
    
    func goToPhotoInfoView(_ photo: Photo) {
        presenter?.goToPhotoInfoView(photo)
    }
}

extension PhotosView: PhotosViewProtocol {
    
    func setPhotos(_ photos: [Photo]) {
        self.photos = photos
        collection.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    
    func updateImageForPhoto (_ photo: Photo) {
        let photoIndex = self.photos.index(of: photo)!
        let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
        if let cell = collection.cellForItem(at: photoIndexPath as IndexPath) as? PhotosCollectionCellView {
            cell.updateWithImage(image: photo.image)
        }
    }
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        getPhotoForCell(photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        goToPhotoInfoView(photo)
    }
    
    // DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotosCollectionCellView
        return cell
    }
}
