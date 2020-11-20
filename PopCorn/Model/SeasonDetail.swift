//
//  SeasonDetail.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct SeasonDetail: Decodable {
    let airDate: String?
    let episodes: [Episode]
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
}

struct Episode: Decodable {
    let airDate: String
    let episodeNumber: Int
    let crew: [Crew]
    let guestStars: [Cast]
    let id: Int
    let name: String
    let overview: String
    let seasonNumber: Int
    let stillPath: String?
}
