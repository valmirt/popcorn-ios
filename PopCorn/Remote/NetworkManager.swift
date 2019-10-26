//
//  NetworkManager.swift
//  PopCorn
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol NetworkManager {
    
    func networkCall <T: Decodable> (url: URL,
                                     execute: @escaping (T?, Error?) -> Void)
    
    func createURL (baseURL: String,
                    path: String,
                    queries: [URLQueryItem]?) -> URL?
}
