//
//  DateFormatter.swift
//  Photorama
//
//  Created by juan sicilia on 17/7/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
