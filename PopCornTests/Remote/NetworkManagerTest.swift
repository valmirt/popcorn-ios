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
    var api: ProdNetworkManager?
    
    override func setUp() {
        api = ProdNetworkManager.shared
    }

    func testSuccessfulNetworkCall() {
        let url = URL(string: "https://www.github.com/valmirt")!
        api?.networkCall(url: url, execute: { (response: ResponseList<Movie>?, error) in })
    }
    
    func testSuccessfulCreateURL() {
        let urlString = "https://www.github.com"
        
        let url = api?.createURL(baseURL: urlString, path: "/valmirt", queries: nil)
        
        XCTAssert(url != nil)
        XCTAssertEqual(url?.absoluteString, "\(urlString)/valmirt")
    }
    
    func testErrorCreateURL() {
        let errorURLString = "askjflaskjf /dfk123,.fadlcçç"
        
        let url = api?.createURL(baseURL: errorURLString, path: "", queries: nil)
        
        XCTAssertNil(url)
    }
    
    func testSuccessfulDecodeJSON() {
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
        movie = try! api?.decodeJSON(type: ResponseList<Movie>.self, data: json)
        XCTAssert(movie != nil)
        XCTAssertEqual(movie?.results[0].title, "Joker")
        XCTAssertEqual(movie?.results[0].backdropPath, "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg")
    }
}
