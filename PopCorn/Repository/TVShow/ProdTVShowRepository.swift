//
//  ProdTVShowRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

class ProdTVShowRepository: ProdBaseRepository, TVShowRepository {
    var delegate: TVShowManagerDelegate?
    
    func updateTVShowList(_ page: Int, path: String) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        load (path, queries, ResponseList<TVShow>.self) { (response, error) in
            if let safe = response {
                self.delegate?.tvShowManager(self, didUpdateTVShowList: safe.results, totalPages: safe.totalPages)
            } else {
                if let err = error {
                    self.delegate?.tvShowManager(self, didUpdateError: err)
                }
            }
        }
    }
    
    func detailTVShow(id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Constants.Web.API_KEY)
        ]
        
        load("/tv/\(id)", queries, TVShowDetail.self) { response, error in
            if let safe = response {
                self.delegate?.tvShowManager(self, didUpdateTVShowDetail: safe)
            } else {
                if let err = error {
                    self.delegate?.tvShowManager(self, didUpdateError: err)
                }
            }
        }
    }
}
