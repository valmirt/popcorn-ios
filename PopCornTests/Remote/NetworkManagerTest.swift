//
//  NetworkManagerTest.swift
//  PopCornTests
//
//  Created by Valmir Torres on 29/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import XCTest
@testable import PopCorn

class NetworkManagerTest: XCTestCase {
    
    //System Under Test
    var sut: NetworkManager?
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessfulCreateURL() {
        //Given
        let urlString = "https://www.github.com"
        
        //When
        let url = sut?.createURL(baseURL: urlString, path: "/valmirt", queries: nil)
        
        //Then
        XCTAssert(url != nil)
        XCTAssertEqual(url?.absoluteString, "\(urlString)/valmirt")
    }
    
    func testErrorCreateURL() {
        //Given
        let errorURLString = "askjflaskjf /dfk123,.fadlcçç"
        
        //When
        let url = sut?.createURL(baseURL: errorURLString, path: "", queries: nil)
        
        //Then
        XCTAssertNil(url)
    }
    
    func testSuccessfulDecodeJSON() {
        //Given
        var movie: ResponseList<Movie>?
        let bundle = Bundle(for: NetworkManagerTest.self)
        let url = bundle.url(forResource: "MovieList", withExtension: "json")!
        let json = try! Data(contentsOf: url)
        
        //When
        movie = try! sut?.decodeJSON(type: ResponseList<Movie>.self, data: json)
        
        //Then
        XCTAssert(movie != nil)
        XCTAssertEqual(movie?.results[0].title, "Joker")
        XCTAssertEqual(movie?.results[0].backdropPath, "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg")
    }
    
    func testNetworkCallSuccess() {
        //Given
        let promise = expectation(description: "Success!")
        let url = "\(Web.BASE_URL)/\(Web.VERSION_API)/movie/550?api_key=\(Web.API_KEY)"
        
        //When
        sut?.networkCall(url: URL(string: url)!, execute: { (result: Result<MovieDetail, NetworkError>) in
            defer { promise.fulfill() }
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        
        //Then
        wait(for: [promise], timeout: 3.0)
    }
    
    func testNetworkCallErrorStatusCode() {
        //Given
        let promise = expectation(description: "Success!")
        let url = "\(Web.BASE_URL)/\(Web.VERSION_API)/movie/550"
        
        //When
        sut?.networkCall(url: URL(string: url)!, execute: { (result: Result<MovieDetail, NetworkError>) in
            defer { promise.fulfill() }
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Api response error! Status code: 401")
            }
        })
        
        //Then
        wait(for: [promise], timeout: 3.0)
    }
    
    func testNetworkCallErrorDecodeJson() {
        //Given
        let promise = expectation(description: "Success!")
        let url = "\(Web.BASE_URL)/\(Web.VERSION_API)/movie/550?api_key=\(Web.API_KEY)"
        
        //When
        sut?.networkCall(url: URL(string: url)!, execute: { (result: Result<ResponseList<Movie>, NetworkError>) in
            defer { promise.fulfill() }
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Invalid data, try again later...")
            }
        })
        
        //Then
        wait(for: [promise], timeout: 3.0)
    }
}
