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
    
    func testSuccessMoviesCount() {
        //Given
        sut = ListingViewModel(typeMedia: .tvShow, filter: .popular, FakeMovieRepository(), FakeTVShowRepository())
        
        //When
        sut?.loadData()
        let result = self.sut?.count
        
        //Then
        XCTAssertEqual(result, 3)
    }
    
    func testErrorMoviesCount() {
        //Given
        let fakeTVRepository = FakeTVShowRepository()
        fakeTVRepository.errorLoad = true
        sut = ListingViewModel(typeMedia: .tvShow, filter: .popular, FakeMovieRepository(), fakeTVRepository)
        
        //When
        sut?.loadData()
        let result = self.sut?.count
        
        //Then
        XCTAssertEqual(result, 0)
    }
    
    func testMediaViewModelContent() {
        //Given
        sut = ListingViewModel(typeMedia: .movie, filter: .popular, FakeMovieRepository())
        sut?.loadData()
        
        //When
        let viewModel = sut?.getMediaViewModel(at: IndexPath(row: 0, section: 0))
        
        //Then
        XCTAssertEqual(viewModel?.title, "Fake Movie 1")
    }
}
