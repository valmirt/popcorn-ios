//
//  ProdMovieService.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ProdMovieService: MovieService {
    
    private init () {}
    
    static let shared = ProdMovieService()
}
