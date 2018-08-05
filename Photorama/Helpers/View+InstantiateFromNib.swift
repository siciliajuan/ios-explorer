//
//  View+InstantiateFromNib.swift
//  Photorama
//
//  Created by juan sicilia on 6/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public class func instantiateFromNib<T: UIViewController>(viewType: T.Type) -> T? {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as? T
    }
    
    public class func instantiateFromNib() -> Self? {
        return instantiateFromNib(viewType: self)
    }
    
}
