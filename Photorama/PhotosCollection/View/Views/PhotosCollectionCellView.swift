//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by juan sicilia on 22/7/17.
//  Copyright © 2017 juan sicilia. All rights reserved.
//

import UIKit

class PhotosCollectionCellView: UICollectionViewCell {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        Bundle.main.loadNibNamed("PhotosCollectionCellView", owner: self, options: nil)
        self.backgroundView = self.view
        updateWithImage(image: nil)
    }
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
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
}
