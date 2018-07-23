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
    
    var photo: Photo!
    let cellIdentifier = "UITableViewCell"
    var tags: [String] = []
    var selectedIndexPaths = [NSIndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad()
        updateTags()
    }
    
    func prepareContentView() {
        Bundle.main.loadNibNamed("TagsMainView", owner: self, options: nil)
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }
    
    @IBAction func done(sender: AnyObject) {
        presenter?.dismissTags()
    }
    
    @IBAction func addNewTag(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add Tag", message: nil, preferredStyle: .alert)
        alertController.addTextField(){
            (texField) -> Void in
            texField.placeholder = "Tag name"
            texField.autocapitalizationType = .words
        }
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action) -> Void in
            if let tagName = alertController.textFields?.first!.text {
                self.presenter?.saveTag(tagName)
                self.presenter?.updateTags()
                self.reloadSections()
            }
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateTags() {
        _ = photo.tags.map(){
            if let index = tags.index(of:$0) {
                let indexPath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }
    
    func reloadSections() {
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func removePhotoTag(_ tag: String) {
        photo.removeTagObject(tag: tag)
    }
    
    func addPhotoTag(_ tag: String) {
        photo.addTagObject(tag: tag)
    }
    
    func commitPersistentData() {
        presenter?.commitPersistentData(photo: photo)
    }
}

extension TagsView: TagsViewProtocol {
    
    func setTags(_ tags: [String]) {
        self.tags = tags
    }
}

extension TagsView: UITableViewDelegate, UITableViewDataSource {
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        if let index = selectedIndexPaths.index(of:indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            removePhotoTag(tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            addPhotoTag(tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        commitPersistentData()
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
        let name = tag
        cell?.textLabel?.text = name
        return cell!
    }
}



