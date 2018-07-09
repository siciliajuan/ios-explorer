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
    
    
    var store: PhotoStore!
    var photo: Photo!
    var selectedIndexPaths = [NSIndexPath]()
    
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: TagsPresenterProtocol?
    
    let tagDataSource = TagsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tagDataSource
        tableView.delegate = self
        updateTags()
        presenter?.viewDidLoad()
    }
    
}

extension TagsView: TagsViewProtocol {
    
}

extension TagsView: UITableViewDelegate {

    
    
    
    @IBAction func done(sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
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
                let context = self.store.coreDataStack.mainQueueContext
                let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
                newTag.setValue(tagName, forKey: "name")
                do {
                    try self.store.coreDataStack.saveChanges()
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
    }
    
    func updateTags() {
        let tags = try! store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        tagDataSource.tags = tags
        for tag in photo.tags {
            if let index = tagDataSource.tags.index(of:tag) {
                let indexPath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndexPaths.index(of:indexPath as NSIndexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

}

