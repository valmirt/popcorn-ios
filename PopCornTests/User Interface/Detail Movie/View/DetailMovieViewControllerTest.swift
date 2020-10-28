//
//  DetailMovieViewControllerTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 27/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class DetailMovieViewControllerTest: XCTestCase {
    
    var fakeMovieRepository: FakeMovieRepository?
    
    //System Under Test
    var sut: DetailMovieViewController?
    
    override func setUp() {
        super.setUp()
        fakeMovieRepository = FakeMovieRepository()
        sut = DetailMovieViewController.instatiate(from: .detailMovie)
        sut?.viewModel = DetailMovieViewModel(idMovie: FakeMovieNetworkManager.ID, fakeMovieRepository!)
    }
    
    override func tearDown() {
        fakeMovieRepository = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadingHidden() {
        //Given
        let promise = expectation(description: "Success!")
        
        //When
        let _ = sut?.view
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            promise.fulfill()
            XCTAssertTrue(self.sut?.loadingSpinner.isHidden ?? false)
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func testCorrectDataShow() {
        //Given
        let promise = expectation(description: "Success!")
        let expected = FakeMovieNetworkManager.fakeDetail()
        
        //When
        let _ = sut?.view
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            promise.fulfill()
            XCTAssertEqual(self.sut?.labelTitle.text!, expected.title)
            XCTAssertEqual(self.sut?.labelGenres.text!, expected.genresFormatted)
            XCTAssertEqual(self.sut?.labelCountries.text!, expected.countriesFormatted)
            XCTAssertEqual(self.sut?.labelStatus.text!, expected.status)
            XCTAssertEqual(self.sut?.labelReleaseDate.text!, expected.yearDate)
            XCTAssertEqual(self.sut?.labelRuntime.text!, "\(expected.runtime!) min")
            XCTAssertEqual(self.sut?.tvOverview.text!, expected.overview)
            XCTAssertEqual(self.sut?.labelCompanies.text!, expected.companiesFormatted)
        }
        wait(for: [promise], timeout: 2.0)
    }
}
