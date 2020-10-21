//
//  FilterTabBar.swift
//  PopCorn
//
//  Created by Valmir Junior on 21/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

enum FilterTabBar {
    case popular(TypeContent), nowPlaying(TypeContent), topRated(TypeContent)
    
    var typeMedia: TypeContent {
        switch self {
        case .popular(let type):
            return type
        case .nowPlaying(let type):
            return type
        case .topRated(let type):
            return type
        }
    }
    var typeFilter: FilterContent {
        switch self {
        case .popular:
            return .popular
        case .nowPlaying(let type):
            if type == .movie {
                return .nowPlaying
            }
            return .airingToday
        case .topRated:
            return .topRated
        }
    }
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        }
    }
    var image: UIImage? {
        switch self {
        case .popular:
            return UIImage(systemName: "heart.fill")
        case .nowPlaying:
            return UIImage(systemName: "pin.fill")
        case .topRated:
            return UIImage(systemName: "star.fill")
        }
    }
    var order: Int {
        switch self {
        case .popular:
            return 0
        case .nowPlaying:
            return 1
        case .topRated:
            return 2
        }
    }
}
