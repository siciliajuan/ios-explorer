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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        presenter?.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTag))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    func prepareContentView() {
        Bundle.main.loadNibNamed("TagsMainView", owner: self, options: nil)
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }
    
    @objc func done() {
        presenter?.didDoneTags(forPhoto: photo)
    }
    
    @objc func addNewTag() {
        
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
                self.presenter?.didSave(tag: tagName)
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
            }
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: alertControllerCancelActionTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
        if photo.tags.index(of: tag) != nil {
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



