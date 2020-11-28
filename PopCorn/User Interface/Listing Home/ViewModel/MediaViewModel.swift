//
//  MediaViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class MediaViewModel {
    private let movieRepo: MovieRepositoryProtocol
    private let tvRepo: TVShowRepositoryProtocol
    private let movie: Movie?
    private let tvShow: TVShow?
    
    init(movie: Movie? = nil, tvShow: TVShow? = nil, _ movieRepo: MovieRepositoryProtocol = MovieRepository(), _ tvRepo: TVShowRepositoryProtocol = TVShowRepository()) {
        self.movie = movie
        self.tvShow = tvShow
        self.movieRepo = movieRepo
        self.tvRepo = tvRepo
    }
    
    var title: String {
        movie?.title ?? tvShow?.name ?? ""
    }
    
    var releaseDate: String {
        String(movie?.releaseDate.prefix(4) ?? tvShow?.firstAirDate.prefix(4) ?? "")
    }
    
    var popularity: String {
        String(format: "%.1f", movie?.popularity ?? tvShow?.popularity ?? 0)
    }
    
    var rate: String {
        String(format: "%.1f", movie?.voteAverage ?? tvShow?.voteAverage ?? 0)
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        if let movie = movie {
            if let backdrop = movie.backdropPath {
                let path = "\(Web.IMAGE_W780)\(backdrop)"
                movieRepo.updateImage(baseURL: base, path: path) { image in
                    onComplete(image)
                }
            } else {
                onComplete(UIImage(systemName: "photo"))
            }
        }
        if let tvShow = tvShow {
            if let backdrop = tvShow.backdropPath {
                let path = "\(Web.IMAGE_W780)\(backdrop)"
                tvRepo.updateImage(baseURL: base, path: path) { image in
                    onComplete(image)
                }
            } else {
                onComplete(UIImage(systemName: "photo"))
            }
        }
    }
}
