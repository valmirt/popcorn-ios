//
//  MovieDetailExtensions.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/09/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

extension MovieDetail {
    
    var genresFormatted: String? {
        return genres
            .compactMap({ $0.name })
            .sorted()
            .joined(separator: " | ")
    }
    
    var countriesFormatted: String? {
        return productionCountries
            .compactMap({ $0.name })
            .sorted()
            .joined(separator: " | ")
    }
    
    var companiesFormatted: String? {
        return productionCompanies
            .compactMap({ $0.name })
            .sorted()
            .joined(separator: " | ")
    }
    
    var yearDate: String? {
        return String(releaseDate.split(separator: "-").first ?? "")
    }
}
