//
//  PeopleRepositoryTest.swift
//  PopCornTests
//
//  Created by Valmir Junior on 10/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class PeopleRepositoryTest: XCTestCase, PeopleRepositoryDelegate {
    let fakeAPI = FakePeopleNetworkManager()
    var people: People?
    var filmography: Filmography?
    var error: Error?
    
    //System Under Test
    var sut: PeopleRepository?
    
    override func setUp() {
        super.setUp()
        sut = PeopleRepository(fakeAPI)
        sut?.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        error = nil
        people = nil
        filmography = nil
        super.tearDown()
    }
    
    func testPositivePeopleDetail() {
        //Given
        fakeAPI.typeRequest = .people
        
        //When
        sut?.detailPeople(with: FakePeopleNetworkManager.ID)
        let response = people
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.id, FakePeopleNetworkManager.ID)
    }
    
    func testPositiveFilmography() {
        //Given
        fakeAPI.typeRequest = .filmography
        
        //When
        sut?.combinedFilmography(with: FakePeopleNetworkManager.ID)
        let response = filmography
        
        //Then
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.cast[0].id, 1)
        XCTAssertEqual(response?.cast[1].id, 2)
        XCTAssertTrue(((response?.crew.isEmpty) != nil))
    }
    
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdateError: Error) {
        error = didUpdateError
    }
    
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdatePeople: People) {
        people = didUpdatePeople
    }
    
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdateFilmography: Filmography) {
        filmography = didUpdateFilmography
    }
}
