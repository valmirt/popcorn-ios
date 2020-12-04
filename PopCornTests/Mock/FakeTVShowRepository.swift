//
//  FakeTVShowRepository.swift
//  PopCornTests
//
//  Created by Valmir Junior on 26/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit
@testable import PopCorn

class FakeTVShowRepository: TVShowRepositoryProtocol {
    
    var errorLoad = false
    weak var delegate: TVShowRepositoryDelegate?
    
    func updateTVShowList(_ page: Int, path: String) {
        if errorLoad {
            delegate?.tvShowRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeTVShowNetworkManager.fakeList()
            delegate?.tvShowRepository(self, didUpdateTVShowList: fakeResult.results, totalPages: fakeResult.totalPages)
        }
    }
    
    func detailTVShow(with id: Int) {
        if errorLoad {
            delegate?.tvShowRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeTVShowNetworkManager.fakeDetail()
            delegate?.tvShowRepository(self, didUpdateTVShowDetail: fakeResult)
        }
    }
    
    func detailSeason(with id: Int, and seasonNumber: Int) {
        if errorLoad {
            delegate?.tvShowRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
//            let fakeResult = FakeTVShowNetworkManager.fakeDetail()
//            delegate?.tvShowRepository(self, didUpdateSeasonDetail: <#T##SeasonDetail#>)
        }
    }
    
    func updateImage(baseURL: String, path: String, _ handler: @escaping (UIImage?) -> Void) {
        if errorLoad {
            delegate?.tvShowRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            handler(UIImage(systemName: "photo"))
        }
    }
}


