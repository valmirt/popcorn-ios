//
//  ProdNetworkManager.swift
//  PopCorn
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ProdNetworkManager: NetworkManager {
    
    private init () {}
    static let shared = ProdNetworkManager()
    
    func networkCall<T: Decodable>(url: URL, execute: @escaping (T?, Error?) -> Void) {
        let session = URLSession (
            configuration: URLSessionConfiguration.ephemeral,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        let task = session.dataTask(with: url) { (data, _, error) in
            if let safeData = data {
                let response = try? self.decodeJSON(type: T.self, data: safeData)
                if let resp = response {
                    execute(resp, error)
                } else {
                    execute(nil, NetworkError.invalidDecodeJSON)
                }
            } else {
                execute(nil, NetworkError.invalidData)
            }
        }
        task.resume()
    }
    
    func createURL(baseURL: String, path: String, queries: [URLQueryItem]? = nil) -> URL? {
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queries
        return component?.url
    }
    
    internal func decodeJSON<T: Decodable>(type: T.Type, data: Data) throws -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
}
