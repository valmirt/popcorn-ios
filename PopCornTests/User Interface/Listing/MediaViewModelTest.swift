//
//  MediaViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 26/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class MediaViewModelTest: XCTestCase {
    
    //System Under Test
    var sut: MediaViewModel?

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMediaTitle() {
        //Given
        sut = MediaViewModel(movie: nil, tvShow: FakeTVShowNetworkManager.fakeList().results[0])
        
        //When
        let result = sut?.title
        
        //Then
        XCTAssertEqual(result, FakeTVShowNetworkManager.fakeList().results[0].name)
    }
    
    func testMediaReleaseDate() {
        //Given
        sut = MediaViewModel(movie: nil, tvShow: FakeTVShowNetworkManager.fakeList().results[1])
        
        //When
        let result = sut?.releaseDate
        
        //Then
        XCTAssertEqual(result, "2020")
    }
    
    func testMediaPopularity() {
        //Given
        sut = MediaViewModel(movie: nil, tvShow: FakeTVShowNetworkManager.fakeList().results[2])
        
        //When
        let result = sut?.popularity
        
        //Then
        XCTAssertEqual(result, "10.0")
    }
    
    func testMediaRate() {
        //Given
        sut = MediaViewModel(movie: nil, tvShow: FakeTVShowNetworkManager.fakeList().results[1])
        
        //When
        let result = sut?.rate
        
        //Then
        XCTAssertEqual(result, "23.0")
    }
}
