//
//  NetworkManager.swift
//  PopCorn
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func networkCall <T: Decodable> (url: URL, execute: @escaping (Result<T, NetworkError>) -> Void)
    
    func createURL (baseURL: String, path: String, queries: [URLQueryItem]?) -> URL?
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private let config: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true //Signal 3G/4G
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.httpMaximumConnectionsPerHost = 5
        
        return configuration
    }()
    private lazy var session = URLSession(configuration: config)
    
    func networkCall<T: Decodable>(url: URL, execute: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                execute(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                execute(.failure(.defaultError))
                return
            }
            
            if !(200...299 ~= response.statusCode) {
                execute(.failure(.statusCode(response.statusCode)))
                return
            }
            
            guard let result = try? self.decodeJSON(type: T.self, data: data) else {
                execute(.failure(.invalidDecodeJSON))
                return
            }
            
            execute(.success(result))
        }.resume()
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
