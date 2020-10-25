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
        super.tearDown()
    }
    
    func testPositiveTVShowListRequest() {
        //Gven
        error = nil
        result = nil
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
        error = nil
        detail = nil
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
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateError: Error) {
        error = didUpdateError
    }
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateTVShowList: [TVShow], totalPages: Int) {
        result = didUpdateTVShowList
    }
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateTVShowDetail: TVShowDetail) {
        detail = didUpdateTVShowDetail
    }
}
