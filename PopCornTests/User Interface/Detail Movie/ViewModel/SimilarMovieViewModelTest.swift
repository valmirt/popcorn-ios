//
//  SimilarMovieViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 27/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class SimilarMovieViewModelTest: XCTestCase {
    
    //System Under Test
    var sut: SimilarMovieViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetImage() {
        //Given
        let promise = expectation(description: "Success!")
        sut = SimilarMovieViewModel(movie: FakeMovieNetworkManager.fakeList().results[0], FakeMovieRepository())
        
        //When
        sut?.getImage(onComplete: { (image) in
            promise.fulfill()
            XCTAssertTrue(true)
        })
        
        //Then
        wait(for: [promise], timeout: 1.0)
    }
}
