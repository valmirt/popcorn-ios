//
//  Movie.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let backdropPath: String?
    let genreIds: Array<Genre>
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: Array<Company>
    let productionCountries: Array<Country>
    let releaseDate: String
    let runtime: Int
    let status: String
    let title: String
    let voteAverage: Int
    let voteCount: Int
}
