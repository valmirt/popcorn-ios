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
        
        load(path, queries, ResponseList<Movie>.self) { (response, error) in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdateMovieList: safe.results, totalPages: safe.totalPages)
            } else {
                if let err = error {
                    self.delegate?.movieManager(self, didUpdateError: err)
                }
            }
        }
    }
    
    func detailMovie(id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY)
        ]
        
        load("/movie/\(id)", queries, MovieDetail.self) { response, error in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdateMovieDetail: safe)
            } else {
                if let err = error {
                    self.delegate?.movieManager(self, didUpdateError: err)
                }
            }
        }
    }
}
