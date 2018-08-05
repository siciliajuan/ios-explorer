//
//  PhotosView+Delegate.swift
//  Photorama
//
//  Created by juan sicilia on 5/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

extension PhotosView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // la vista debería ser agnostica
        let photo = photos[indexPath.row]
        presenter.getImageCell(forPhoto: photo)
    }
    
    func tableView(_ UITableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        presenter.didShowPhotoInfoView(forPhoto: photo)
    }
}
