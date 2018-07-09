//
//  TagsView.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsView: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: TagsPresenterProtocol?
    
    let tagDataSource = TagsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tagDataSource
        //tableView.delegate = self
        presenter?.viewDidLoad()
    }
    
}

extension TagsView: TagsViewProtocol {
    
}

//extension TagsView: UITableViewDelegate, UITableViewDataSource {
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tagDataSource.tags[indexPath.row]
        if let index = selectedIndexPaths.index(of:indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            photo.removeTagObject(tag: tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            photo.addTagObject(tag: tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        do {
            try store.coreDataStack.saveChanges()
        } catch let error {
            print("Core Data save failed: \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndexPaths.index(of:indexPath as NSIndexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    // DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // preguntar al presenter
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let tag = tags[indexPath.row]
        let name = tag.value(forKey: "name") as! String
        cell?.textLabel?.text = name
        return cell!
    }
    */
//}

