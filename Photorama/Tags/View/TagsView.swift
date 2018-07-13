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
    
    var contentView: TagsViewMainViewInputProtocol?
    
    var presenter: TagsPresenterProtocol?
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad()
        updateTags()
    }
    
    func prepareContentView() {
        contentView = TagsViewMainView(frame: self.view.frame, view: self, photo: photo)
        self.view.addSubview(contentView as! UIView)
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
                self.contentView?.reloadSections()
            }
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateTags() {
        contentView?.updateTags()
    }
}

extension TagsView: TagsViewProtocol {
    
    func setTags(_ tags: [NSManagedObject]) {
        contentView?.setTags(tags)
    }
}

extension TagsView: TagsViewMainViewOutputProtocol {
    
    func removePhotoTag(_ tag: NSManagedObject) {
        photo.removeTagObject(tag: tag)
    }
    
    func addPhotoTag(_ tag: NSManagedObject) {
        photo.addTagObject(tag: tag)
    }
    
    func commitPersistentData() {
        presenter?.commitPersistentData()
    }
}

