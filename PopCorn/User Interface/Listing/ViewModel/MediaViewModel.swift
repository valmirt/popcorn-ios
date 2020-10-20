//
//  MediaViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class MediaViewModel {
    lazy var movieRepo: MovieRepositoryProtocol = MovieRepository()
    lazy var tvRepo: TVShowRepositoryProtocol = TVShowRepository()
    var movie: Movie?
    var tvShow: TVShow?
    
    init(movie: Movie? = nil, tvShow: TVShow? = nil) {
        self.movie = movie
        self.tvShow = tvShow
    }
    
    var title: String {
        movie?.title ?? tvShow?.name ?? ""
    }
    
    var releaseDate: String {
        String(movie?.releaseDate.prefix(4) ?? tvShow?.firstAirDate.prefix(4) ?? "")
    }
    
    var popular: String {
        String(format: "%.1f", movie?.popularity ?? tvShow?.popularity ?? 0)
    }
    
    var rate: String {
        String(format: "%.1f", movie?.voteAverage ?? tvShow?.voteAverage ?? 0)
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Constants.Web.BASE_URL_IMAGE
        if let movie = movie {
            if let backdrop = movie.backdropPath {
                let path = "\(Constants.Web.IMAGE_W780)\(backdrop)"
                movieRepo.updateImage(baseURL: base, path: path) { image in
                    onComplete(image)
                }
            } else {
                onComplete(UIImage(systemName: "photo"))
            }
        }
        if let tvShow = tvShow {
            if let backdrop = tvShow.backdropPath {
                let path = "\(Constants.Web.IMAGE_W780)\(backdrop)"
                tvRepo.updateImage(baseURL: base, path: path) { image in
                    onComplete(image)
                }
            } else {
                onComplete(UIImage(systemName: "photo"))
            }
        }
    }
}
