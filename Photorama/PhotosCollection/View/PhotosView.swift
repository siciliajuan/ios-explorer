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
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    
    var photos = [Photo]()
    
    
    /*
     PhotosViewController when loads ask for the recent photos to the store using
     the fetchRecentPhotos method pasing as callback function a the clousure defined
     where is set the photos to the data source and then reload the colection to show
     the photos
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        store.fetchRecentPhotos() {
            (result) -> Void in
            let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
            let allPhotos = try! self.store.fetchMainQueuePhotos(predicate: nil, sortDescriptors: [sortByDateTaken])
            OperationQueue.main.addOperation{
                self.photos = allPhotos
                self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
        }
    }
}

extension PhotosView: PhotosViewProtocol {
    
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        store.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            OperationQueue.main.addOperation{
                let photoIndex = self.photos.index(of: photo)!
                let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
                if let cell = self.collectionView.cellForItem(at: photoIndexPath as IndexPath) as? PhotosViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    /*
     It's triggered when a cell recieves a tap
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        self.navigationController?.pushViewController(PhotoInfoRoute.createPhotoInfoModule(forPhoto: photo, forPhotoStore: store), animated: true)
    }
    
    // DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotosViewCell
        return cell
    }
}
