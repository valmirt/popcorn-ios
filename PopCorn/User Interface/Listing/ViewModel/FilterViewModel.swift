//
//  FilterViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

final class FilterViewModel {
    
    private var type: TypeContent
    
    init(typeMedia: TypeContent) {
        self.type = typeMedia
    }
    
    func getListingViewModel(by positionScreen: Int) -> ListingViewModel {
        switch positionScreen {
        case 0:
            return ListingViewModel(typeMedia: type, filter: .popular)
        case 1:
            if type == .movie {
                return ListingViewModel(typeMedia: type, filter: .nowPlaying)
            } else {
                return ListingViewModel(typeMedia: type, filter: .airingToday)
            }
        case 2:
            return ListingViewModel(typeMedia: type, filter: .topRated)
        default:
            return ListingViewModel(typeMedia: type, filter: .popular)
        }
    }
}
