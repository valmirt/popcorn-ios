//
//  CreditViewModelTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 27/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class CreditViewModelTest: XCTestCase {
    
    //System Under Test
    var sut: CreditViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCastData() {
        //Given
        let cast = Cast(
            castId: 1,
            character: "Gandalf",
            creditId: "1",
            id: 1,
            name: "Ian McKellen",
            profilePath: nil
        )
        sut = CreditViewModel(cast: cast)
        
        //When
        let name = sut?.name
        let char = sut?.charOrJob
        
        //Then
        XCTAssertEqual(name, cast.name)
        XCTAssertEqual(char, cast.character)
    }
    
    func testCrewData() {
        //Given
        let crew = Crew(
            creditId: "1",
            id: 1,
            job: "Director",
            name: "Quentin Tarantino",
            profilePath: nil
        )
        
        sut = CreditViewModel(crew: crew)
        
        //When
        let name = sut?.name
        let job = sut?.charOrJob
        
        //Then
        XCTAssertEqual(name, crew.name)
        XCTAssertEqual(job, crew.job)
    }
    
    func testCreatorData() {
        //Given
        let creator = Creator(id: 1, name: "Eric Kripke", profilePath: nil)
        sut = CreditViewModel(creator: creator)
        
        //When
        let name = sut?.name
        let char = sut?.charOrJob
        
        //Then
        XCTAssertEqual(name, creator.name)
        XCTAssertEqual(char, "")
    }
    
    func testErrorData() {
        //Given
        sut = CreditViewModel()
        
        //When
        let name = sut?.name
        let char = sut?.charOrJob
        
        //Then
        XCTAssertEqual(name, "")
        XCTAssertEqual(char, "")
    }
    
    func testGetImage() {
        //Given
        let promise = expectation(description: "Success!")
        sut = CreditViewModel(repository: FakeMovieRepository())
        
        //When
        sut?.getImage(onComplete: { (image) in
            promise.fulfill()
            XCTAssertTrue(true)
        })
        
        //Then
        wait(for: [promise], timeout: 1.0)
    }
}
