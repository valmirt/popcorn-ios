//
//  DetailTVShowViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 16/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class DetailTVShowViewModelTest: XCTestCase {
    
    var repository: FakeTVShowRepository?
    //System Under Test
    var sut: DetailTVShowViewModel?
    
    override func setUp() {
        super.setUp()
        repository = FakeTVShowRepository()
        sut = DetailTVShowViewModel(idTV: FakeTVShowNetworkManager.ID, repository!)
    }

    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }

    func testCorrectData() {
        //Given
        let expected = FakeTVShowNetworkManager.fakeDetail()
        
        //When
        sut?.loadData()
        
        //Then
        XCTAssertEqual(sut?.seasonsCount, expected.seasons?.count)
        XCTAssertEqual(sut?.creatorsCount, expected.seasons?.count)
        XCTAssertEqual(sut?.title, expected.name)
        XCTAssertEqual(sut?.genres, expected.genresFormatted)
        XCTAssertEqual(sut?.countries, expected.countriesFormatted)
        XCTAssertEqual(sut?.inProduction, "In Production: \(expected.inProduction ?? false ? "Yes" : "No")")
        XCTAssertEqual(sut?.runtime, "Runtime: \(expected.runTimeFormatted ) min")
        XCTAssertEqual(sut?.numberSeasons, "Seasons: \(expected.numberOfSeasons ?? 0)")
        XCTAssertEqual(sut?.numberEpisodes, "Episodes: \(expected.numberOfEpisodes ?? 0)")
    }
    
    func testErrorData() {
        //Given
        repository?.errorLoad = true
        
        //When
        sut?.loadData()
        
        //Then
        XCTAssertEqual(sut?.seasonsCount, 0)
        XCTAssertEqual(sut?.creatorsCount, 0)
        XCTAssertEqual(sut?.title, "")
        XCTAssertEqual(sut?.genres, "")
        XCTAssertEqual(sut?.countries, "")
        XCTAssertEqual(sut?.inProduction, "In Production: No")
        XCTAssertEqual(sut?.runtime, "Runtime: ~ min")
        XCTAssertEqual(sut?.numberSeasons, "Seasons: 0")
        XCTAssertEqual(sut?.numberEpisodes, "Episodes: 0")
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
