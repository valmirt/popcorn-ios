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
    var api: NetworkManager?
    
    override func setUp() {
        api = NetworkManager.shared
    }
    
    func testSuccessfulCreateURL() {
        //Given
        let urlString = "https://www.github.com"
        
        //When
        let url = api?.createURL(baseURL: urlString, path: "/valmirt", queries: nil)
        
        //Then
        XCTAssert(url != nil)
        XCTAssertEqual(url?.absoluteString, "\(urlString)/valmirt")
    }
    
    func testErrorCreateURL() {
        //Given
        let errorURLString = "askjflaskjf /dfk123,.fadlcçç"
        
        //When
        let url = api?.createURL(baseURL: errorURLString, path: "", queries: nil)
        
        //Then
        XCTAssertNil(url)
    }
    
    func testSuccessfulDecodeJSON() {
        //Given
        var movie: ResponseList<Movie>?
        let json = """
        {
            "page": 1,
            "total_results": 10000,
            "total_pages": 500,
            "results": [
                {
                    "popularity": 432.456,
                    "vote_count": 4373,
                    "video": false,
                    "poster_path": "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
                    "id": 475557,
                    "adult": false,
                    "backdrop_path": "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
                    "original_language": "en",
                    "original_title": "Joker",
                    "genre_ids": [
                        80,
                        18,
                        53
                    ],
                    "title": "Joker",
                    "vote_average": 8.6,
                    "overview": "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
                    "release_date": "2019-10-04"
                }
            ]
        }
        """.data(using: .utf8)!
        
        //When
        movie = try! api?.decodeJSON(type: ResponseList<Movie>.self, data: json)
        
        //Then
        XCTAssert(movie != nil)
        XCTAssertEqual(movie?.results[0].title, "Joker")
        XCTAssertEqual(movie?.results[0].backdropPath, "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg")
    }
}
