//
//  PhotosCollectionView.swift
//  Photorama
//
//  Created by juan sicilia on 12/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotosCollectionView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var collection: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareCollection()
    }
    
    func prepareCollection() {
        Bundle.main.loadNibNamed("PhotosCollectionView", owner: self, options: nil)
        self.addSubview(self.contentView)
    }
}
