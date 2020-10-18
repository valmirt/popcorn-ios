//
//  HomeViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    func getFilterViewModel(isMovie: Bool) -> FilterViewModel {
        if isMovie {
            return FilterViewModel(typeMedia: .movie)
        } else {
            return FilterViewModel(typeMedia: .tvShow)
        }
    }
}
