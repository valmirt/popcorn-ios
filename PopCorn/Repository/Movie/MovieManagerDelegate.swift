//
//  MovieManagerDelegate.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func movieManager (_ manager: MovieRepository,
                       didUpdateMovieList: [Movie],
                       totalPages: Int)
    
    func movieManager (_ manager: MovieRepository, didUpdateError: Error)
}

//MARK: - Default Implementations

extension MovieManagerDelegate {
    func movieManager (_ manager: MovieRepository,
                       didUpdateMovieList: [Movie],
                       totalPAges: Int) {
        //this is a empty implementation to allow this method to be optional
    }
}
