//
//  PhotosCollectionView.swift
//  Photorama
//
//  Created by juan sicilia on 12/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosCollectionView: UIView {
    
    @IBOutlet var collection: UICollectionView!
    
    var view: PhotosCollectionViewOutputProtocol?
    let cellIdentifier = "UICollectionViewCell"
    var photos = [Photo]()
    
    init(frame: CGRect, view: PhotosView) {
        super.init(frame: frame)
        self.view = view
        prepare()
        collection.delegate = self
        collection.dataSource = self
        collection.register(PhotosCollectionCellView.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        Bundle.main.loadNibNamed("PhotosCollectionView", owner: self, options: nil)
        /*
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        collection.collectionViewLayout = layout
         */
        self.addSubview(self.collection)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collection.frame = self.bounds
    }
}

extension PhotosCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        view?.getPhotoForCell(photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        view?.goToPhotoInfoView(photo)
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

extension PhotosCollectionView: PhotosCollectionViewInputProtocol {
    
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
