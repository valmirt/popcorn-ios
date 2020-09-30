//
//  ProdMovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class ProdMovieRepository: ProdBaseRepository, MovieRepository {
    
    weak var delegate: MovieManagerDelegate?
    
    func updateMovieList(_ page: Int = 1, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load(path, queries, ResponseList<Movie>.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieManager(self, didUpdateMovieList: data.results, totalPages: data.totalPages)
            case .failure(let error):
                self.delegate?.movieManager(self, didUpdateError: error)
            }
        }
    }
    
    func detailMovie(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY)
        ]
        
        load("/\(Constants.Web.VERSION_API)/movie/\(id)", queries, MovieDetail.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieManager(self, didUpdateMovieDetail: data)
            case .failure(let error):
                self.delegate?.movieManager(self, didUpdateError: error)
            }
        }
    }
    
    func creditMovie(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY)
        ]
        
        load("/\(Constants.Web.VERSION_API)/movie/\(id)/credits", queries, Credit.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieManager(self, didUpdateCreditMovie: data)
            case .failure(let error):
                self.delegate?.movieManager(self, didUpdateError: error)
            }
        }
    }
}
