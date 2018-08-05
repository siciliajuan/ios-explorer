//
//  TagsView-Delegate.swift
//  Photorama
//
//  Created by juan sicilia on 5/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

extension TagsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        if photo.tags.index(of: tag) != nil {
            // la vista debería ser pasiva
            photo.removeTagObject(tag: tag)
        } else {
            photo.addTagObject(tag: tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if photo.tags.index(of: tags[indexPath.row]) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
