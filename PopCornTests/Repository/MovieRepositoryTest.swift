//
//  MovieRepositoryTest.swift
//  PopCornTests
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class MovieRepositoryTest: XCTestCase, MovieRepositoryDelegate {
    let fakeAPI = FakeMovieNetworkManager()
    var movieRepository: MovieRepositoryProtocol?
    var result: [Movie]?
    var detail: MovieDetail?
    var error: Error?

    override func setUp() {
        movieRepository = MovieRepository(fakeAPI)
        
        movieRepository?.delegate = self
    }
    
    func testPositiveListResult() {
        //Gven
        error = nil
       
        //When
        movieRepository?.updateMovieList(1, path: "")
        let movies = result
        
        //Then
        XCTAssertNil(error)
        XCTAssert(movies != nil)
        XCTAssert(movies != nil && movies?[0].title == "Fake Movie 1")
    }
    
    func testPositiveDetailResult() {
        //Given
        error = nil
        
        //When
        movieRepository?.detailMovie(with: FakeMovieNetworkManager.ID)
        let movie = detail
        
        //Then
        XCTAssertNil(error)
        XCTAssert(movie != nil)
        XCTAssert(movie?.id == FakeMovieNetworkManager.ID)
        XCTAssert(movie?.title == "Fake Movie")
    }
    
    func testErrorResult() {
        //Given
        result = nil
        fakeAPI.errorCreateURL = true
        fakeAPI.errorLoad = true
        
        //When
        movieRepository?.updateMovieList(1, path: "")
        let err = error
        
        //Then
        XCTAssertNil(result)
        XCTAssert(err != nil)
        XCTAssert(err != nil
            && (
                err?.localizedDescription == "We are having trouble contacting the server, try again later..."
                || err?.localizedDescription == "We are having server issues, try again later..."
                || err?.localizedDescription == "Something is wrong, try again later..."
            )
        )
    }
    
    func movieRepository(_ manager: MovieRepository, didUpdateMovieList: [Movie], totalPages: Int) {
        result = didUpdateMovieList
    }
    
    func movieRepository(_ manager: MovieRepository, didUpdateError: Error) {
        error = didUpdateError
    }
    
    func movieRepository(_ manager: MovieRepository, didUpdateMovieDetail: MovieDetail) {
        detail = didUpdateMovieDetail
    }
}
