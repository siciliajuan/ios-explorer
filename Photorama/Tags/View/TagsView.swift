//
//  TagsView.swift
//  Photorama
//
//  Created by juan sicilia on 9/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class TagsView: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    var presenter: TagsPresenterProtocol!
    
    let cellIdentifier = "UITableViewCell"
    var tags: [String] = []
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter.viewDidLoad()
    }
    
    func prepareContentView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTag))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    @objc func done() {
        presenter.didDoneTags(forPhoto: photo)
    }
    
    @objc func addNewTag() {
        presenter.didAddTag()
    }
}

extension TagsView: TagsViewProtocol {
    
    func setTags(_ tags: [String]) {
        self.tags = tags
    }
    
    func showAddTagAler() {
        // Localize texts
        let alertControllerTitle = NSLocalizedString("Add Tag", comment: "Alert Controller title")
        let alertControllerPlaceHoler = NSLocalizedString("Tag name", comment: "Alert Controller Placeholder")
        let alertControllerOkActionTitle = NSLocalizedString("OK", comment: "Alert Controller OK action title")
        let alertControllerCancelActionTitle = NSLocalizedString("cancel", comment: "Alert Controller cancel action title")

        let alertController = UIAlertController(title: alertControllerTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField(){
            (texField) -> Void in
            texField.placeholder = alertControllerPlaceHoler
            texField.autocapitalizationType = .words
        }
        let okAction = UIAlertAction(title: alertControllerOkActionTitle, style: .default, handler: {
            (action) -> Void in
            if let tagName = alertController.textFields?.first!.text {
                self.presenter.didSave(tag: tagName)
                // la vista debería ser pasiva
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
            }
        })
        let cancelAction = UIAlertAction(title: alertControllerCancelActionTitle, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}



