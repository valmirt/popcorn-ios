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
    let id: Int
    let popularity: Double
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let posterPath: String?
}
