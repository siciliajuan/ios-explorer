//
//  PhotoInfoMainView.swift
//  Photorama
//
//  Created by juan sicilia on 12/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

class PhotoInfoMainView: UIView {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var contentView: UIView!
    
    @IBAction func showTags() {
        view?.showTags()
    }
    
    var view: PhotoInfoMainViewOutputProtocol?
    
    init(frame: CGRect, view: PhotoInfoView) {
        super.init(frame: frame)
        self.view = view
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func prepare() {
        Bundle.main.loadNibNamed("PhotoInfoMainView", owner: self, options: nil)
        self.addSubview(self.contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.bounds
    }
    
}

extension PhotoInfoMainView: PhotoInfoMainViewInputProtocol {
    
    func setPhotoImage(_ image: UIImage) {
        imageView.image = image
    }
}
