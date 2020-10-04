//
//  ProdTVShowRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class ProdTVShowRepository: ProdBaseRepository, TVShowRepository {
    weak var delegate: TVShowManagerDelegate?
    
    func updateTVShowList(_ page: Int, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load (path, queries, ResponseList<TVShow>.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowManager(self, didUpdateTVShowList: data.results, totalPages: data.totalPages)
            case .failure(let error):
                self.delegate?.tvShowManager(self, didUpdateError: error)
            }
        }
    }
    
    func detailTVShow(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY)
        ]
        
        load("/\(Constants.Web.VERSION_API)/tv/\(id)", queries, TVShowDetail.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.tvShowManager(self, didUpdateTVShowDetail: data)
            case .failure(let error):
                self.delegate?.tvShowManager(self, didUpdateError: error)
            }
        }
    }
}
