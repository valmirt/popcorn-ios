//
//  FakeMovieRepository.swift
//  PopCornTests
//
//  Created by Valmir Junior on 25/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit
@testable import PopCorn

class FakeMovieRepository: MovieRepositoryProtocol {
    var errorLoad = false
    weak var delegate: MovieRepositoryDelegate?
    
    func updateMovieList(_ page: Int, path: String) {
        if errorLoad {
            delegate?.movieRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeMovieNetworkManager.fakeList()
            delegate?.movieRepository(self, didUpdateMovieList: fakeResult.results, totalPages: fakeResult.page)
        }
    }
    
    func detailMovie(with id: Int) {
        if errorLoad {
            delegate?.movieRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeMovieNetworkManager.fakeDetail()
            delegate?.movieRepository(self, didUpdateMovieDetail: fakeResult)
        }
    }
    
    func creditMovie(with id: Int) {
        if errorLoad {
            delegate?.movieRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeMovieNetworkManager.fakeCredit()
            delegate?.movieRepository(self, didUpdateCreditMovie: fakeResult)
        }
    }
    
    func updateSimilarMovies(with id: Int, _ page: Int) {
        if errorLoad {
            delegate?.movieRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakeMovieNetworkManager.fakeList()
            delegate?.movieRepository(self, didUpdateSimilarMovies: fakeResult.results, totalPages: fakeResult.page)
        }
    }
    
    func updateImage(baseURL: String, path: String, _ handler: @escaping (UIImage?) -> Void) {
        if errorLoad {
            delegate?.movieRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            handler(UIImage(systemName: "photo"))
        }
    }
}
