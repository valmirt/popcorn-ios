//
//  MovieRepositoryTest.swift
//  PopCornTests
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class MovieRepositoryTest: XCTestCase, MovieManagerDelegate {
    let fakeAPI = FakeMovieNetworkManager()
    var movieRepository: MovieRepository?
    var result: [Movie]?
    var error: Error?

    override func setUp() {
        movieRepository = ProdMovieRepository(fakeAPI)
    }
    
    func testPositiveListResult () {
        error = nil
        movieRepository?.delegate = self
        
        movieRepository?.updatePopularMovies(0)
        movieRepository?.updateNowPlayingMovies(0)
        movieRepository?.updateTopRatedMovies(0)
        
        let movies = result
        XCTAssertNil(error)
        XCTAssert(movies != nil)
        XCTAssert(movies != nil && movies?[0].title == "Fake Movie 1")
    }
    
    func testErrorResult () {
        result = nil
        movieRepository?.delegate = self
        
        fakeAPI.errorCreateURL = true
        fakeAPI.errorLoad = true
        
        movieRepository?.updatePopularMovies(0)
        movieRepository?.updateNowPlayingMovies(0)
        movieRepository?.updateTopRatedMovies(0)
        
        let err = error
        XCTAssertNil(result)
        XCTAssert(err != nil)
        XCTAssert(err != nil
            && (err?.localizedDescription == "We are having trouble contacting the server, try again later..."
                || err?.localizedDescription == "We are having server issues, try again later..."
                || err?.localizedDescription == "Something is wrong, try again later..."
            )
        )
    }
    
    func movieManager(_ manager: MovieRepository, didUpdatePopularList: [Movie]) {
        result = didUpdatePopularList
    }
    
    func movieManager(_ manager: MovieRepository, didUpdateNowPlayingList: [Movie]) {
        result = didUpdateNowPlayingList
    }
    
    func movieManager(_ manager: MovieRepository, didUpdateTopRatedList: [Movie]) {
        result = didUpdateTopRatedList
    }
    
    func movieManager(_ manager: MovieRepository, didUpdateError: Error) {
        error = didUpdateError
    }
}
