//
//  TagsView.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit
import CoreData

class TagsView: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: TagsPresenterProtocol?
    
    var photo: Photo!
    var tags: [NSManagedObject] = []
    var selectedIndexPaths = [NSIndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.viewDidLoad()
        updateTags()
    }
    
    @IBAction func done(sender: AnyObject) {
        presenter?.dismissTags()
    }
    
    @IBAction func addNewTag(sender: AnyObject) {
        /*
        let alertController = UIAlertController(title: "Add Tag", message: nil, preferredStyle: .alert)
        alertController.addTextField(){
            (texField) -> Void in
            texField.placeholder = "Tag name"
            texField.autocapitalizationType = .words
        }
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action) -> Void in
            if let tagName = alertController.textFields?.first!.text {
                let context = presenter!.store.coreDataStack.mainQueueContext
                let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
                newTag.setValue(tagName, forKey: "name")
                do {
                    try presenter!.store.coreDataStack.saveChanges()
                } catch let error {
                    print("Core Data save failure: \(error)")
                }
                self.updateTags()
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
            }
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
 */
    }
    
    func updateTags() {
        for tag in photo.tags {
            if let index = tags.index(of:tag) {
                let indexPath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }
}

extension TagsView: TagsViewProtocol {
    
    func setTags(_ tags: [NSManagedObject]) {
        self.tags = tags
    }
}

extension TagsView: UITableViewDelegate, UITableViewDataSource {

    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        if let index = selectedIndexPaths.index(of:indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            photo.removeTagObject(tag: tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            photo.addTagObject(tag: tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        presenter?.commitPersistentData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let tag = tags[indexPath.row]
        let name = tag.value(forKey: "name") as! String
        cell?.textLabel?.text = name
        return cell!
    }
}

