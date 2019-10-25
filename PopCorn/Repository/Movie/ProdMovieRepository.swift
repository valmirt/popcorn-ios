//
//  ProdMovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ProdMovieRepository: MovieRepository {
    var delegate: MovieManagerDelegate?
    let movieService: MovieService
    
    init(_ movieService: MovieService = ProdMovieService.shared) {
        self.movieService = movieService
    }
    
}
