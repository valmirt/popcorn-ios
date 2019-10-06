//
//  Season.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct Season: Decodable {
    let id: Int
    let airDate: String
    let episodeCount: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
}
