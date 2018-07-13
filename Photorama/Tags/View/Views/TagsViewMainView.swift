//
//  TagsViewMainView.swift
//  Photorama
//
//  Created by juan sicilia on 13/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

class TagsViewMainView: UIView {
    
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "UITableViewCell"
    
    var view: TagsViewMainViewOutputProtocol?
    var tags: [NSManagedObject] = []
    var selectedIndexPaths = [NSIndexPath]()
    var photo: Photo!
    
    init(frame: CGRect, view: TagsView, photo: Photo) {
        super.init(frame: frame)
        self.view = view
        self.photo = photo
        prepare()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        Bundle.main.loadNibNamed("TagsViewMainView", owner: self, options: nil)
        self.addSubview(self.tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.frame = self.bounds
    }
}

extension TagsViewMainView: TagsViewMainViewInputProtocol {
    
    func reloadSections() {
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func updateTags() {
        for tag in photo.tags {
            if let index = tags.index(of:tag) {
                let indexPath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }
    
    func setTags(_ tags: [NSManagedObject]) {
        self.tags = tags
    }
}

extension TagsViewMainView: UITableViewDelegate, UITableViewDataSource {
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        if let index = selectedIndexPaths.index(of:indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            view?.removePhotoTag(tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            view?.addPhotoTag(tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        view?.commitPersistentData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndexPaths.index(of:indexPath as NSIndexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    // DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let tag = tags[indexPath.row]
        let name = tag.value(forKey: "name") as! String
        cell?.textLabel?.text = name
        return cell!
    }
}

