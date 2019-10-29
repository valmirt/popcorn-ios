//
//  ProdMovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ProdMovieRepository: MovieRepository {
    var delegate: MovieManagerDelegate?
    let api: NetworkManager
    
    init(_ api: NetworkManager = ProdNetworkManager.shared) {
        self.api = api
    }
    
    func updatePopularMovies (_ page: Int = 0) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load ("/movie/popular", queries) { (response, error) in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdatePopularList: safe.results)
            } else {
                if let err = error {
                    self.delegate?.movieManager(self, didUpdateError: err)
                }
            }
        }
    }
    
    func updateNowPlayingMovies (_ page: Int = 0) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load ("/movie/now_playing", queries) { (response, error) in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdateNowPlayingList: safe.results)
            } else {
                if let err = error {
                    self.delegate?.movieManager(self, didUpdateError: err)
                }
            }
        }
    }
    
    func updateTopRatedMovies (_ page: Int = 0) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load ("/movie/top_rated", queries) { (response, error) in
            if let safe = response {
                self.delegate?.movieManager(self, didUpdateTopRatedList: safe.results)
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
