//
//  ProdBaseRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation
import UIKit

class ProdBaseRepository: BaseRepository {
    let api: NetworkManager
    
    init(_ api: NetworkManager = ProdNetworkManager.shared) {
        self.api = api
    }
    
    func updateImage(
        baseURL: String,
        path: String,
        _ handler: @escaping (UIImage?) -> Void
    ) {
        if let url = api.createURL(baseURL: baseURL, path: path, queries: nil) {
            ImageService.getImage(withUrl: url, handler: handler)
        }
    }
    
    
    internal func load <T: Decodable> (
        _ path: String,
        _ queries: [URLQueryItem],
        _ ofType: T.Type,
        _ handler: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = api.createURL(baseURL: Constants.Web.BASE_URL, path: path, queries: queries) else {
            handler(.failure(.invalidURL))
            return
        }
        
        api.networkCall(url: url, execute: handler)
    }
}
