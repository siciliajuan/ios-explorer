//
//  APIClient.swift
//  Photorama
//
//  Created by juan sicilia on 10/9/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import Foundation

enum DataResult {
    case success(Data)
    case failure(Error)
}

enum APIClientError: Error {
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(Error)
}

extension APIClientError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .CouldNotDecodeJSON:
            return "Could not decode JSON"
        case let .BadStatus(status):
            return "Bad status \(status)"
        case let .Other(error):
            return "\(error)"
        }
    }
}

final class APIClient {
    
    init(baseURL: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
    
    func objects<T: Codable>(resource: Resource, completion: @escaping (T) -> Void) {
        data(resource: resource) {
            (result) -> Void in
            switch result {
            case let .success(data):
                guard let objects: T = decode(data) else {
                    fatalError("Error getting data: \(APIClientError.CouldNotDecodeJSON)")
                }
                completion(objects)
            case let .failure(error):
                print("Error getting data: \(error)")
            }
        }
    }
    
    // MARK: - Private
    
    private let baseURL: URL
    private let session: URLSession
    
    private func data(resource: Resource, completion: @escaping (DataResult) -> Void) {
        
        let url = resource.urlFromBaseURL(baseURL)
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) -> Void in
            if let error = error {
                OperationQueue.main.addOperation{
                    completion(.failure(APIClientError.Other(error)))
                }
            } else {
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    fatalError("Couldn't get HTTP response")
                }
                
                if 200 ..< 300 ~= HTTPResponse.statusCode {
                    OperationQueue.main.addOperation{
                        completion(.success(data!))
                    }
                }
                else {
                    OperationQueue.main.addOperation{
                        completion(.failure(APIClientError.BadStatus(status: HTTPResponse.statusCode)))
                    }
                }
            }
            }.resume()
    }
}
