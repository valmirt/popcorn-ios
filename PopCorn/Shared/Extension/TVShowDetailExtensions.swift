//
//  TVShowDetailExtensions.swift
//  PopCorn
//
//  Created by Valmir Junior on 04/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

extension TVShowDetail {
    
    var genresFormatted: String? {
        return genres?
            .compactMap({ $0.name })
            .sorted()
            .joined(separator: " | ")
    }
    
    var countriesFormatted: String? {
        return originCountry?
            .compactMap({ $0 })
            .sorted()
            .joined(separator: " | ")
    }
    
    var runTimeFormatted: String {
        let runtime = episodeRunTime?.sorted()
        guard let list = runtime, let first = list.first, let last = list.last else { return "~" }
        
        if first == last {
            return String(first)
        }
        return "\(first) ~ \(last)"
    }
}
