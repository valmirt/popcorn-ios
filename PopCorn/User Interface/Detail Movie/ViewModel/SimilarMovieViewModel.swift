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
    private lazy var movieRepository: MovieRepositoryProtocol = MovieRepository()
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        if let path = movie.posterPath {
            let base = Constants.Web.BASE_URL_IMAGE
            let completePath = "\(Constants.Web.IMAGE_W185)\(path)"
            movieRepository.updateImage(baseURL: base, path: completePath) { image in
                onComplete(image)
            }
        }
    }
}
