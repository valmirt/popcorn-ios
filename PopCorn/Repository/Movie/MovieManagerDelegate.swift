//
//  MovieManagerDelegate.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func movieManager (
        _ manager: MovieRepository,
        didUpdateMovieList: [Movie],
        totalPages: Int
    )
    
    func movieManager (_ manager: MovieRepository, didUpdateMovieDetail: MovieDetail)
    
    func movieManager (_ manager: MovieRepository, didUpdateError: Error)
}

//MARK: - Default Implementations

extension MovieManagerDelegate {
    func movieManager (
        _ manager: MovieRepository,
        didUpdateMovieList: [Movie],
        totalPages: Int
    ) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func movieManager (_ manager: MovieRepository, didUpdateMovieDetail: MovieDetail) {
        //this is an empty implementation to allow this method to be optional
    }
}
