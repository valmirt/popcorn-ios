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
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}
