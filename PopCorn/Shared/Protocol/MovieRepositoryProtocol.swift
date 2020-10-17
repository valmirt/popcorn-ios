//
//  MovieRepositoryProtocol.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol MovieRepositoryProtocol: BaseRepositoryProtocol {
    var delegate: MovieRepositoryDelegate? { get set }
    
    func updateMovieList(_ page: Int, path: String)
    
    func detailMovie(with id: Int)
    
    func creditMovie(with id: Int)
    
    func updateSimilarMovies(with id: Int, _ page: Int)
}
