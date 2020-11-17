//
//  SeasonViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 16/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class SeasonViewModelTest: XCTestCase {
    
    var repository: FakeTVShowRepository?
    //System Under Test
    var sut: SeasonViewModel?
    
    override func setUp() {
        super.setUp()
        repository = FakeTVShowRepository()
        sut = SeasonViewModel(season: FakeTVShowNetworkManager.fakeDetail().seasons?[0], repository!)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }
    
    func testCorrectData() {
        //Given
        let expected = FakeTVShowNetworkManager.fakeDetail().seasons?[0]
        
        //When
        
        //Then
        XCTAssertEqual(sut?.title, expected?.name)
        XCTAssertEqual(sut?.overview, expected?.overview)
    }
    
    func testErrorData() {
        //Given
        sut = SeasonViewModel(season: nil, repository!)
        
        //When
        
        //Then
        XCTAssertEqual(sut?.title, "")
        XCTAssertEqual(sut?.overview, "")
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
