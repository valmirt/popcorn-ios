//
//  TVShowRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class TVShowRepository: BaseRepository, TVShowRepositoryProtocol {
    weak var delegate: TVShowRepositoryDelegate?
    
    func updateTVShowList(_ page: Int, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load (path, queries, ResponseList<TVShow>.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowRepository(self, didUpdateTVShowList: data.results, totalPages: data.totalPages)
            case .failure(let error):
                self.delegate?.tvShowRepository(self, didUpdateError: error)
            }
        }
    }
    
    func detailTVShow(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/tv/\(id)", queries, TVShowDetail.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowRepository(self, didUpdateTVShowDetail: data)
            case .failure(let error):
                self.delegate?.tvShowRepository(self, didUpdateError: error)
            }
        }
    }
    
    func detailSeason(with id: Int, and seasonNumber: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/tv/\(id)/season/\(seasonNumber)", queries, SeasonDetail.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowRepository(self, didUpdateSeasonDetail: data)
            case .failure(let error):
                self.delegate?.tvShowRepository(self, didUpdateError: error)
            }
        }
    }
    
    func episodeCredit(with id: Int, and seasonNumber: Int, and episodeNumber: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/tv/\(id)/season/\(seasonNumber)/episode/\(episodeNumber)/credits", queries, Credit.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowRepository(self, didUpdateEpisodeCredit: data)
            case .failure(let error):
                self.delegate?.tvShowRepository(self, didUpdateError: error)
            }
        }
    }
}

//MARK: - Movie Repository delegate
protocol TVShowRepositoryDelegate: class {
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateTVShowList: [TVShow], totalPages: Int)
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateTVShowDetail: TVShowDetail)
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateSeasonDetail: SeasonDetail)
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateEpisodeCredit: Credit)
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateError: Error)
}

//MARK: - Default delegate Implementations
extension TVShowRepositoryDelegate {
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateTVShowList: [TVShow], totalPages: Int) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateTVShowDetail: TVShowDetail) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateEpisodeCredit: Credit) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func tvShowRepository (_ manager: TVShowRepositoryProtocol, didUpdateSeasonDetail: SeasonDetail) {
        //this is an empty implementation to allow this method to be optional
    }
}
