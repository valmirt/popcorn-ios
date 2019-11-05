//
//  ProdMovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class ProdMovieRepository: ProdBaseRepository, MovieRepository {
    var delegate: MovieManagerDelegate?
    
    func updateMovieList(_ page: Int = 1, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load (path, queries) { (response, error) in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdateMovieList: safe.results)
            } else {
                if let err = error {
                    self.delegate?.movieManager(self, didUpdateError: err)
                }
            }
        }
    }
    
    //MARK: - Private helper functions
    
    private func load (_ path: String,
                       _ queries: [URLQueryItem],
                       _ handler: @escaping (ResponseList<Movie>?, Error?) -> Void) {
        
        if let url = api.createURL(baseURL: Constants.Web.BASE_URL, path: path, queries: queries) {
            api.networkCall(url: url, execute: handler)
        } else {
            handler(nil, NetworkError.invalidURL)
        }
    }
}
