//
//  TVShow.swift
//  PopCorn
//
//  Created by Valmir Torres on 04/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let backdropPath: String?
    let id: Int
    let popularity: Double
    let firstAirDate: String
    let name: String
    let voteAverage: Double
}
