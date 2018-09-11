//
//  Resource.swift
//  Photorama
//
//  Created by juan sicilia on 10/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

enum Method2: String {
    case GET = "GET"
}

protocol Resource {
    var method: Method2 { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Resource {
    
    var method: Method2 {
        return .GET
    }
    
    func urlFromBaseURL(_ baseURL: URL) -> URL {
        let URL = baseURL.appendingPathComponent(path)
        
        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional
        
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        var queryItems = [URLQueryItem]()
        
        queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        components.queryItems = queryItems
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        return finalURL
    }
}
