//
//  PhotosViewController.swift
//  Photorama
//
//  Created by juan sicilia on 20/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    
    /*
     PhotosViewController when loads ask for the recent photos to the store using
     the fetchRecentPhotos method pasing as callback function a the clousure defined
     where is set the photos to the data source and then reload the colection to show
     the photos
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        store.fetchRecentPhotos() {
            (result) -> Void in
            let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
            let allPhotos = try! self.store.fetchMainQueuePhotos(predicate: nil, sortDescriptors: [sortByDateTaken])
            OperationQueue.main.addOperation{
                self.photoDataSource.photos = allPhotos
                self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
        }
    }
    
    /*
     Loads the cell image when it's going to be shown
     */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        store.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            OperationQueue.main.addOperation{
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
                if let cell = self.collectionView.cellForItem(at: photoIndexPath as IndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    /*
     It's triggered when a cell recieves a tap
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        self.navigationController?.pushViewController(PhotoInfoRoute.createPhotoInfoModule(forPhoto: photo, forPhotoStore: store), animated: true)
    }
}
