//
//  MovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class MovieRepository: BaseRepository, MovieRepositoryProtocol {
    
    weak var delegate: MovieRepositoryDelegate?
    
    func updateMovieList(_ page: Int = 1, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load(path, queries, ResponseList<Movie>.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieRepository(self, didUpdateMovieList: data.results, totalPages: data.totalPages)
            case .failure(let error):
                self.delegate?.movieRepository(self, didUpdateError: error)
            }
        }
    }
    
    func detailMovie(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/movie/\(id)", queries, MovieDetail.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieRepository(self, didUpdateMovieDetail: data)
            case .failure(let error):
                self.delegate?.movieRepository(self, didUpdateError: error)
            }
        }
    }
    
    func creditMovie(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/movie/\(id)/credits", queries, Credit.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieRepository(self, didUpdateCreditMovie: data)
            case .failure(let error):
                self.delegate?.movieRepository(self, didUpdateError: error)
            }
        }
    }
    
    func updateSimilarMovies(with id: Int, _ page: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load("/\(Web.VERSION_API)/movie/\(id)/similar", queries, ResponseList<Movie>.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.movieRepository(self, didUpdateSimilarMovies: data.results, totalPages: data.totalPages)
            break
            case .failure(let error):
                self.delegate?.movieRepository(self, didUpdateError: error)
            }
        }
    }
}

//MARK: - Movie Repository delegate
protocol MovieRepositoryDelegate: class {
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateMovieList: [Movie], totalPages: Int)
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateMovieDetail: MovieDetail)
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateCreditMovie: Credit)
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateError: Error)
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateSimilarMovies: [Movie], totalPages: Int)
}

//MARK: - Default delegate Implementations
extension MovieRepositoryDelegate {
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateMovieList: [Movie], totalPages: Int) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateSimilarMovies: [Movie], totalPages: Int) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateMovieDetail: MovieDetail) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func movieRepository (_ manager: MovieRepositoryProtocol, didUpdateCreditMovie: Credit) {
        //this is an empty implementation to allow this method to be optional
    }
}
