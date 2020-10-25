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
    var result: [Movie]?
    var detail: MovieDetail?
    var credit: Credit?
    var error: Error?
    
    //System Under Test
    var sut: MovieRepositoryProtocol?

    override func setUp() {
        super.setUp()
        sut = MovieRepository(fakeAPI)
        sut?.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPositiveMovieListResult() {
        //Gven
        error = nil
        fakeAPI.typeRequest = .list
       
        //When
        sut?.updateMovieList(1, path: "")
        let movies = result
        
        //Then
        XCTAssertNil(error)
        XCTAssert(movies != nil)
        XCTAssert(movies != nil && movies?[0].title == "Fake Movie 1")
    }
    
    func testPositiveDetailResult() {
        //Given
        error = nil
        fakeAPI.typeRequest = .detail
        
        //When
        sut?.detailMovie(with: FakeMovieNetworkManager.ID)
        let movie = detail
        
        //Then
        XCTAssertNil(error)
        XCTAssert(movie != nil)
        XCTAssert(movie?.id == FakeMovieNetworkManager.ID)
        XCTAssert(movie?.title == "Fake Movie")
    }
    
    func testPositiveCreditMovieResult() {
        //Given
        error = nil
        fakeAPI.typeRequest = .credit
        
        //When
        sut?.creditMovie(with: FakeMovieNetworkManager.ID)
        let creditMovie = credit
        
        //Then
        XCTAssertNil(error)
        XCTAssert(creditMovie != nil)
        XCTAssert(creditMovie?.id == FakeMovieNetworkManager.ID)
    }
    
    func testPositiveSimilarMoviesResult() {
        //Given
        error = nil
        result = nil
        fakeAPI.typeRequest = .list
        
        //When
        sut?.updateSimilarMovies(with: FakeMovieNetworkManager.ID, 1)
        let movies = result
        
        //Then
        XCTAssertNil(error)
        XCTAssert(result != nil)
        XCTAssert(movies != nil && movies?[0].title == "Fake Movie 1")
    }
    
    func testErrorResult() {
        //Given
        result = nil
        fakeAPI.errorCreateURL = true
        fakeAPI.errorLoad = true
        
        //When
        sut?.updateMovieList(1, path: "")
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
    
    func movieRepository(_ manager: MovieRepository, didUpdateCreditMovie: Credit) {
        credit = didUpdateCreditMovie
    }
    
    func movieRepository(_ manager: MovieRepository, didUpdateSimilarMovies: [Movie], totalPages: Int) {
        result = didUpdateSimilarMovies
    }
}
