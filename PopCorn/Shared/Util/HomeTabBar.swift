//
//  HomeTabBar.swift
//  PopCorn
//
//  Created by Valmir Junior on 21/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

enum HomeTabBar {
    case movies, tvShow, profile, search
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .tvShow:
            return "TV Shows"
        case .profile:
            return "Profile"
        case .search:
            return "Search"
        }
    }
    var image: UIImage? {
        switch self {
        case .movies:
            return UIImage(systemName: "film")
        case .tvShow:
            return UIImage(systemName: "tv")
        case .profile:
            return UIImage(systemName: "person")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        }
    }
    var navIsHidden: Bool {
        switch self {
        case .movies:
            return true
        case .tvShow:
            return true
        case .profile:
            return false
        case .search:
            return false
        }
    }
    var navnPreferLargeTitles: Bool {
        switch self {
        case .movies:
            return false
        case .tvShow:
            return false
        case .profile:
            return true
        case .search:
            return true
        }
    }
    var order: Int {
        switch self {
        case .movies:
            return 0
        case .tvShow:
            return 1
        case .profile:
            return 2
        case .search:
            return 3
        }
    }
}
