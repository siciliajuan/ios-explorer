//
//  PhotosView+DataSource.swift
//  Photorama
//
//  Created by juan sicilia on 5/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

extension PhotosView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotosTableCellView
        cell.photo = photos[indexPath.row]
        
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "PhotosTableCell_\(indexPath.row)"
        return cell
    }
}
