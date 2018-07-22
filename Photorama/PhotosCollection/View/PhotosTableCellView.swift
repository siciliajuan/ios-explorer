//
//  PhotoTableViewCell.swift
//  Photorama
//
//  Created by juan sicilia on 22/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotosTableCellView: UITableViewCell {
    
    @IBOutlet var view: UITableViewCell!
    
    @IBOutlet var customImageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDate: UILabel!
    
    var photo: Photo! {
        didSet {
            labelDate.text = DateHelper.dateFormatter.string(from: photo.dateTaken)
            labelTitle.text = photo.title
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        Bundle.main.loadNibNamed("PhotosTableCellView", owner: self, options: nil)
        self.selectionStyle = .none
        self.backgroundView = self.view
        updateWithImage(image: nil)
    }
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            customImageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            customImageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view.frame = self.bounds
    }
}
