//
//  TVShowRepositoryTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 25/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class TVShowRepositoryTest: XCTestCase, TVShowRepositoryDelegate {
    let fakeAPI = FakeTVShowNetworkManager()
    var result: [TVShow]?
    var detail: TVShowDetail?
    var credit: Credit?
    var season: SeasonDetail?
    var error: Error?
    
    //System Under Test
    var sut: TVShowRepository?

    override func setUp() {
        super.setUp()
        sut = TVShowRepository(fakeAPI)
        sut?.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        error = nil
        result = nil
        credit = nil
        season = nil
        super.tearDown()
    }
    
    func testPositiveTVShowListRequest() {
        //Gven
        fakeAPI.typeRequest = .list
       
        //When
        sut?.updateTVShowList(1, path: "")
        let tvList = result
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(tvList)
        XCTAssertEqual( tvList?[0].name, "Fake TV Show 1")
    }
    
    func testPositiveDetailRequest() {
        //Given
        fakeAPI.typeRequest = .detail
        
        //When
        sut?.detailTVShow(with: FakeTVShowNetworkManager.ID)
        let tv = detail
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(tv)
        XCTAssertEqual(tv?.id, FakeMovieNetworkManager.ID)
        XCTAssertEqual(tv?.name, "Fake TV Show")
    }
    
    func testPositiveCreditRequest() {
        //Given
        fakeAPI.typeRequest = .credit
        
        //When
        sut?.episodeCredit(with: FakeTVShowNetworkManager.ID, and: FakeTVShowNetworkManager.ID, and: FakeTVShowNetworkManager.ID)
        let creditResult = credit
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(creditResult)
        XCTAssertEqual(creditResult?.id, FakeMovieNetworkManager.ID)
    }
    
    func testPositiveSeasonDetailRequest() {
        //Given
        fakeAPI.typeRequest = .season
        
        //When
        sut?.detailSeason(with: FakeTVShowNetworkManager.ID, and: FakeTVShowNetworkManager.ID)
        let seasonResult = season
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(seasonResult)
        XCTAssertEqual(seasonResult?.id, FakeMovieNetworkManager.ID)
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        error = didUpdateError
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateTVShowList: [TVShow], totalPages: Int) {
        result = didUpdateTVShowList
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateTVShowDetail: TVShowDetail) {
        detail = didUpdateTVShowDetail
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateEpisodeCredit: Credit) {
        credit = didUpdateEpisodeCredit
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateSeasonDetail: SeasonDetail) {
        season = didUpdateSeasonDetail
    }
}
