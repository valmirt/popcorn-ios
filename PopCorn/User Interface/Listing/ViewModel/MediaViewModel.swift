//
//  MediaViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

final class MediaViewModel {
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
}
