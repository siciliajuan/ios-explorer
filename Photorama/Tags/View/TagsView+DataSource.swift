//
//  TagsView+DataSource.swift
//  Photorama
//
//  Created by juan sicilia on 5/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

extension TagsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let tag = tags[indexPath.row]
        let name = tag
        cell?.textLabel?.text = name
        return cell!
    }
}
