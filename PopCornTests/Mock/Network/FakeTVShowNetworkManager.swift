//
//  FakeTVShowNetworkManager.swift
//  PopCornTests
//
//  Created by Valmir Junior on 25/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation
@testable import PopCorn

enum FakeTVShowNetworkRequest {
    case list, detail, credit, season
}

class FakeTVShowNetworkManager: NetworkManagerProtocol {
    private var typeReturn: Int = 0
    var errorCreateURL = false
    var errorLoad = false
    var typeRequest: FakeTVShowNetworkRequest = .list
    static let ID = 1
    
    func networkCall<T: Decodable>(url: URL, execute: @escaping (Result<T, NetworkError>) -> Void) {
        if errorLoad {
            execute(.failure(.defaultError))
        } else {
            switch typeRequest {
            case .list:
                execute(.success(FakeTVShowNetworkManager.fakeList() as! T))
            case .detail:
                execute(.success(FakeTVShowNetworkManager.fakeDetail() as! T))
            case .credit:
                execute(.success(FakeTVShowNetworkManager.fakeCredit() as! T))
            case .season:
                execute(.success(FakeTVShowNetworkManager.fakeSeasonDetail() as! T))
            }
        }
    }
    
    func createURL(baseURL: String, path: String, queries: [URLQueryItem]?) -> URL? {
        if errorCreateURL {
            return nil
        }
        
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queries
        return component?.url
    }
    
    static func fakeCredit() -> Credit {
        Credit(id: FakeTVShowNetworkManager.ID, cast: [], crew: [], guestStars: [])
    }
    
    static func fakeSeasonDetail() -> SeasonDetail {
        SeasonDetail(
            airDate: nil,
            episodes: [
                Episode(
                    airDate: "",
                    episodeNumber: 1,
                    crew: [],
                    guestStars: [],
                    id: 1,
                    name: "Fake Episode",
                    overview: "...",
                    seasonNumber: 1,
                    stillPath: nil
                )
            ],
            id: FakeTVShowNetworkManager.ID,
            name: "Fake Season",
            overview: "...",
            posterPath: nil,
            seasonNumber: 1
        )
    }
    
    static func fakeDetail() -> TVShowDetail {
        TVShowDetail(
            id: FakeTVShowNetworkManager.ID,
            createdBy: [
                Creator(
                    id: 1,
                    name: "Vince Giligan",
                    profilePath: nil
                )
            ],
            episodeRunTime: nil,
            firstAirDate: "2020-04-04",
            genres: [
                Genre(name: "Sci-Fi")
            ],
            inProduction: false,
            lastAirDate: "2020-04-04",
            name: "Fake TV Show",
            numberOfEpisodes: 201,
            numberOfSeasons: 3,
            originCountry: ["BR"],
            originalLanguage: "Portuguese",
            originalName: "Fake TV Show",
            overview: "",
            popularity: 10.0,
            posterPath: nil,
            productionCompanies: [],
            seasons: [
                Season(
                    airDate: "",
                    episodeCount: 25,
                    id: 1,
                    name: "Fake Season 1",
                    overview: "",
                    posterPath: nil,
                    seasonNumber: 1
                )
            ],
            status: "released",
            type: nil,
            voteAverage: 100
        )
    }
        
    static func fakeList() -> ResponseList<TVShow> {
        ResponseList(
            page: 1,
            totalResults: 3,
            totalPages: 1,
            results: [
                TVShow(
                    backdropPath: nil,
                    id: 1,
                    popularity: 9.0,
                    firstAirDate: "2020-04-04",
                    name: "Fake TV Show 1",
                    voteAverage: 20.0
                ),
                TVShow(
                    backdropPath: nil,
                    id: 2,
                    popularity: 8.0,
                    firstAirDate: "2020-04-04",
                    name: "Fake TV Show 2",
                    voteAverage: 23.0
                ),
                TVShow(
                    backdropPath: nil,
                    id: 3,
                    popularity: 10.0,
                    firstAirDate: "2020-04-04",
                    name: "Fake TV Show 3",
                    voteAverage: 40.0
                ),
            ]
        )
    }
}
