//
//  DetailMovieViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 27/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class DetailMovieViewModelTest: XCTestCase {
    
    var repository: FakeMovieRepository?
    //System Under Test
    var sut: DetailMovieViewModel?
    
    override func setUp() {
        super.setUp()
        repository = FakeMovieRepository()
        sut = DetailMovieViewModel(idMovie: FakeMovieNetworkManager.ID, repository!)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }
    
    func testCorrectData() {
        //Given
        let expectedDetail = FakeMovieNetworkManager.fakeDetail()
        let expectedSimilar = FakeMovieNetworkManager.fakeList().results
        let expectedCredit = FakeMovieNetworkManager.fakeCredit()
        
        //When
        sut?.loadData()
        
        //Then
        XCTAssertEqual(sut?.title, expectedDetail.title)
        XCTAssertEqual(sut?.genres, expectedDetail.genresFormatted)
        XCTAssertEqual(sut?.countries, expectedDetail.countriesFormatted)
        XCTAssertEqual(sut?.status, expectedDetail.status)
        XCTAssertEqual(sut?.date, expectedDetail.yearDate)
        XCTAssertEqual(sut?.runtime, "\(expectedDetail.runtime!) min")
        XCTAssertEqual(sut?.overview, expectedDetail.overview)
        XCTAssertEqual(sut?.companies, expectedDetail.companiesFormatted)
        XCTAssertEqual(sut?.similarMoviesCount, expectedSimilar.count)
        XCTAssertEqual(sut?.creditCount, expectedCredit.crew.count + expectedCredit.cast.count )
    }
    
    func testErrorData() {
        //Given
        repository?.errorLoad = true
        
        //When
        sut?.loadData()
        
        //Then
        XCTAssertEqual(sut?.title, "")
        XCTAssertEqual(sut?.genres, "")
        XCTAssertEqual(sut?.countries, "")
        XCTAssertEqual(sut?.status, "")
        XCTAssertEqual(sut?.date, "")
        XCTAssertEqual(sut?.runtime, "0 min")
        XCTAssertEqual(sut?.overview, "")
        XCTAssertEqual(sut?.companies, "")
        XCTAssertEqual(sut?.similarMoviesCount, 0)
        XCTAssertEqual(sut?.creditCount, 0)
    }
    
    func testGetImage() {
        //Given
        let promise = expectation(description: "Success!")
        
        //When
        sut?.getImage(onComplete: { (image) in
            promise.fulfill()
            XCTAssertTrue(true)
        })
        
        //Then
        wait(for: [promise], timeout: 1.0)
    }
}
