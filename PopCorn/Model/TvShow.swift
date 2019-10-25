//
//  TVShow.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let backdropPath: String?
    let episodeRunTime: Array<Int>
    let firstAirDate: String
    let genres: Array<Genre>
    let id: Int
    let inProduction: Bool
    let lastAirDate: String
    let name: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originalName: String
    let originalLanguage: String
    let originCountry: Array<String>
    let overview: String
    let posterPath: String?
    let popularity: Double
    let productionCompanies: Array<Company>
    let voteAverage: Int
    let voteCount: Int
    let status: String
}
