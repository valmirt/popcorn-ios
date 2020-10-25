//
//  ListingViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 25/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class ListingViewModelTest: XCTestCase {
    
    //System Under Test
    var sut: ListingViewModel?

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessFilterName() {
        //Given
        sut = ListingViewModel(typeMedia: .movie, filter: .topRated, FakeMovieRepository())
        
        //When
        let result = sut?.filterName
        
        //Then
        XCTAssertEqual(result, "Top Rated")
    }
    
    func testIsMovieResult() {
        //Given
        sut = ListingViewModel(typeMedia: .movie, filter: .popular, FakeMovieRepository())
        
        //When
        let result = sut?.isMovie
        
        //Then
        XCTAssertNotNil(result)
        XCTAssertTrue(result ?? false)
    }
    
    func testSuccessCount() {
        //Given
        sut = ListingViewModel(typeMedia: .movie, filter: .popular, FakeMovieRepository())
        sut?.loadData()
        
        //When
        let result = sut?.count
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertEqual(result, 3)
        }
    }
}
