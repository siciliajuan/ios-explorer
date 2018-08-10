//
//  TestHelpers.swift
//  PhotoramaTests
//
//  Created by juan sicilia on 9/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

class TestHelpers {
    
    static func createRandomTags(amount: Int) -> [String] {
        var tags = [String]()
        for _ in 0 ..< amount {
            tags.append(createRandomTag())
        }
        return tags
    }
    
    static func createRandomTag() -> String {
        return NSUUID().uuidString
    }
    
    static func createGenericPhoto() -> Photo {
        return Photo(title: "generic title", photoID: "1", remoteURL: URL(string: "www.invented.io/url-very-invented")!, photoKey: "uniqueidentifier", dateTaken: DateHelper.dateFormatter.date(from: "1988-10-18 23:59:59")!, tags: [])
    }
}
