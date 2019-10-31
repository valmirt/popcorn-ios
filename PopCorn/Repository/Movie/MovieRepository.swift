//
//  MovieRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol MovieRepository: BaseRepository {
    
    var delegate: MovieManagerDelegate? { get set }
    
    func updatePopularMovies (_ page: Int)
    
    func updateNowPlayingMovies (_ page: Int)
    
    func updateTopRatedMovies (_ page: Int)
}
