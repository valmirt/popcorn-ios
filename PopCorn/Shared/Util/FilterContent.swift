//
//  FilterContent.swift
//  PopCorn
//
//  Created by Valmir Junior on 23/08/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

enum FilterContent {
    case popular, nowPlaying, topRated, airingToday
    
    var rawValue: (api: String, name: String) {
        switch self {
        case .popular:
            return ("popular", "Popular")
        case .nowPlaying:
            return ("now_playing", "Now Playing")
        case .topRated:
            return ("top_rated", "Top Rated")
        case .airingToday:
            return ("airing_today", "Now Playing")
        }
    }
}
