//
//  TVShowDetail.swift
//  PopCorn
//
//  Created by Valmir Torres on 10/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct TVShowDetail : Decodable {
    let id: Int?
    let createdBy: [Creator]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let inProduction: Bool?
    let lastAirDate: String?
    let name: String?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Company]?
    let seasons: [Season]?
    let status: String?
    let type: String?
    let voteAverage: Double?
}

struct Creator: Decodable {
    let id: Int?
    let name: String?
    let profilePath: String?
}

struct Season: Decodable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int?
    let name: String?
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int?
}
