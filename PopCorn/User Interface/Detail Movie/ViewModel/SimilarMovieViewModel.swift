//
//  SimilarMovieViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SimilarMovieViewModel {
    // MARK: - Properties
    private let movieRepository: MovieRepositoryProtocol
    private let movie: Movie
    
    init(movie: Movie, _ repository: MovieRepositoryProtocol = MovieRepository()) {
        self.movie = movie
        self.movieRepository = repository
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Constants.Web.BASE_URL_IMAGE
        let completePath = "\(Constants.Web.IMAGE_W185)\(movie.posterPath ?? "")"
        movieRepository.updateImage(baseURL: base, path: completePath) { image in
            onComplete(image)
        }
    }
}
