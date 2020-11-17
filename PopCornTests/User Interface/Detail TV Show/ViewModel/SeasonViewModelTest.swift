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
        super.tearDown()
    }
    
    func testCorrectData() {
        //Given
        
        //When
        
        //Then
    }
    
    func testErrorData() {
        //Given
        
        //When
        
        //Then
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
