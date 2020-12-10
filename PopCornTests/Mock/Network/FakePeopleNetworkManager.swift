//
//  FakePeopleNetworkManager.swift
//  PopCornTests
//
//  Created by Valmir Junior on 10/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation
@testable import PopCorn

enum FakePeopleNetworkRequest {
    case people, filmography
}

final class FakePeopleNetworkManager: NetworkManagerProtocol {
    private var typeReturn: Int = 0
    var errorCreateURL = false
    var errorLoad = false
    var typeRequest: FakePeopleNetworkRequest = .people
    static let ID = 1
    
    func networkCall<T>(url: URL, execute: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        if errorLoad {
            execute(.failure(.defaultError))
        } else {
            switch typeRequest {
            case .people:
                execute(.success(FakePeopleNetworkManager.fakeDetailPeople() as! T))
            case .filmography:
                execute(.success(FakePeopleNetworkManager.fakeDetailPeople() as! T))
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
    
    static func fakeDetailPeople() -> People {
        People(
            biography: "",
            birthday: nil,
            knownForDepartment: "acting",
            deathday: nil,
            id: ID,
            name: "Fake People",
            popularity: 10.0,
            placeOfBirth: nil,
            profilePath: nil
        )
    }
    
    static func fakeFilmography() -> Filmography {
        Filmography(
            cast: [
                CreditedFilmography(
                    id: 1,
                    posterPath:nil,
                    mediaType: "tv"
                ),
                CreditedFilmography(
                    id: 2,
                    posterPath:nil,
                    mediaType: "movie"
                )
            ],
            crew: []
        )
    }
}
