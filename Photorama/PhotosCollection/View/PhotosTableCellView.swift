//
//  PhotoTableViewCell.swift
//  Photorama
//
//  Created by juan sicilia on 22/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotosTableCellView: UITableViewCell {
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare()
    }
    
    func prepare() {
        self.selectionStyle = .none
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
}
