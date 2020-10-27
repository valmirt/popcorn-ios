//
//  ListingTableViewControllerTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 26/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class ListingTableViewControllerTest: XCTestCase {
    
    var fakeMovieRepository: FakeMovieRepository?
    
    //System Under Test
    var sut: ListingTableViewController?
    
    override func setUp() {
        super.setUp()
        sut = ListingTableViewController.instatiate(from: .listing)
        fakeMovieRepository = FakeMovieRepository()
        sut?.viewModel = ListingViewModel(typeMedia: .movie, filter: .nowPlaying, fakeMovieRepository!)
    }
    
    override func tearDown() {
        sut = nil
        fakeMovieRepository = nil
        super.tearDown()
    }
    
    func testListingScreenTitle() {
        //Given
        sut?.viewModel = ListingViewModel(typeMedia: .movie, filter: .topRated, FakeMovieRepository())
        
        //When
        let _ = sut?.view
        
        //Then
        XCTAssertEqual(sut?.title, FilterContent.topRated.rawValue.name)
    }
    
    func testSuccessListTitle() {
        //Given
        let promise = expectation(description: "Success!")
        
        //When
        let _ = sut?.view
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            promise.fulfill()
            let cell = self.sut?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MediaTableViewCell
            XCTAssertEqual(cell.titleLabel?.text!, "Fake Movie 1")
        }
        wait(for: [promise], timeout: 1.0)
    }
    
    func testHiddenLoadingError() {
        //Given
        fakeMovieRepository?.errorLoad = true
        let promise = expectation(description: "Success!")
        
        //When
        let _ = sut?.view
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            promise.fulfill()
            XCTAssertFalse(self.sut?.loadingIndicator.isAnimating ?? true)
        }
        wait(for: [promise], timeout: 1.0)
    }
}
