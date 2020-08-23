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
    
    func networkCall<T: Decodable>(
        url: URL,
        execute: @escaping (T?, Error?) -> Void
    ) {
        if errorLoad {
            execute(nil,  NetworkError.defaultError)
        } else {
            execute(fakeList() as? T, nil)
        }
    }
    
    func createURL(
        baseURL: String,
        path: String,
        queries: [URLQueryItem]?
    ) -> URL? {
        if errorCreateURL {
            return nil
        }
        
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queries
        return component?.url
    }
    
    private func fakeList() -> ResponseList<Movie> {
        let result: [Movie] = [
            Movie(
                backdropPath: nil,
                id: 0,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5
            ),
            Movie(
                backdropPath: nil,
                id: 1,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5
            ),
            Movie(
                backdropPath: nil,
                id: 2,
                popularity: 99.9,
                releaseDate: "2019/10/25",
                title: "Fake Movie 1",
                voteAverage: 5
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
