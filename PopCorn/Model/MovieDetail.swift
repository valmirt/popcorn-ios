//
//  MovieDetail.swift
//  PopCorn
//
//  Created by Valmir Torres on 10/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct MovieDetail : Decodable {
    let id: Int
    let genres: [Genre]
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [Company]
    let productionCountries: [Country]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let status: String
    let title: String
    let voteAverage: Double
}

struct Country: Decodable {
    let name: String
}

struct Company: Decodable {
    let logoPath: String?
    let name: String
}

struct Genre: Decodable {
    let name: String
}
