//
//  FakeMovieNetworkManager.swift
//  PopCornTests
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import PopCorn


class FakeMovieNetworkManager: NetworkManager {
    private var typeReturn: Int = 0
    var errorCreateURL = false
    var errorLoad = false
    static let ID = 1
    
    func networkCall<T: Decodable>(url: URL, execute: @escaping (Result<T, NetworkError>) -> Void) {
        if errorLoad {
            execute(.failure(.defaultError))
        } else {
            if url.absoluteString.contains("movie/\(FakeMovieNetworkManager.ID)") {
                execute(.success(fakeDetail() as! T))
            } else {
                execute(.success(fakeList() as! T))
            }
        }
    }
    
    func createURL(baseURL: String, path: String, queries: [URLQueryItem]?) -> URL? {
        if errorCreateURL {
            return nil
        }
        
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queries
        return component?.url
    }
    
    private func fakeDetail() -> MovieDetail {
        let result = MovieDetail(
            id: FakeMovieNetworkManager.ID,
            genres: [],
            originalTitle: "Fake Movie",
            overview: "Fake Overview",
            popularity: 0.0,
            posterPath: nil,
            productionCompanies: [],
            productionCountries: [],
            releaseDate: "2020-09-30",
            revenue: 0,
            runtime: 203,
            status: "released",
            title: "Fake Movie",
            voteAverage: 0.0
        )
        
        return result
    }
    
    private func fakeList() -> ResponseList<Movie> {
        let result: [Movie] = [
            Movie(
                backdropPath: nil,
                id: 0,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5,
                posterPath: nil
            ),
            Movie(
                backdropPath: nil,
                id: 1,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5,
                posterPath: nil
            ),
            Movie(
                backdropPath: nil,
                id: 2,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5,
                posterPath: nil
            )
        ]
        
        let response = ResponseList<Movie>(
            page: 0,
            totalResults: 3,
            totalPages: 1,
            results: result
        )
        
        return response
    }
}
