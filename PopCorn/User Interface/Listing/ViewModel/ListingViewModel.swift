//
//  ListingViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol ListingViewModelDelegate: class {
    func onListenerError(with errorMessage: String)
    func onListenerMediaList()
}

final class ListingViewModel {
    
    //MARK: - Properties
    private let typeMedia: TypeContent
    private let filter: FilterContent
    private var movieRepo: MovieRepositoryProtocol
    private var tvRepo: TVShowRepositoryProtocol
    private lazy var movies: [Movie] = []
    private lazy var tv: [TVShow] = []
    private var page = General.FIRST
    private var reloadData = false
    weak var delegate: ListingViewModelDelegate?
    
    var filterName: String {
        filter.rawValue.name
    }
    
    var count: Int {
        switch typeMedia {
        case .movie:
            return movies.count
        case .tvShow:
            return tv.count
        }
    }
    
    var isMovie: Bool {
        typeMedia == .movie
    }
    
    init(typeMedia: TypeContent, filter: FilterContent, _ movieRepo: MovieRepositoryProtocol = MovieRepository(), _ tvRepo: TVShowRepositoryProtocol = TVShowRepository()) {
        self.typeMedia = typeMedia
        self.filter = filter
        self.movieRepo = movieRepo
        self.tvRepo = tvRepo
    }
    
    //MARK: - Methods
    func loadData() {
        page = General.FIRST
        reloadData = true
        switch typeMedia {
        case .movie:
            movieRepo.delegate = self
            movieRepo.updateMovieList(page, path: getPath())
        case .tvShow:
            tvRepo.delegate = self
            tvRepo.updateTVShowList(page, path: getPath())
        }
    }
    
    func getDetailMovieViewModel(at indexPath: IndexPath) -> DetailMovieViewModel {
        DetailMovieViewModel(idMovie: movies[indexPath.row].id)
    }
    
    func getDetailTVShowViewModel(at indexPath: IndexPath) -> DetailTVShowViewModel {
        DetailTVShowViewModel(idTV: tv[indexPath.row].id)
    }
    
    func getMediaViewModel(at indexPath: IndexPath) -> MediaViewModel {
        switch typeMedia {
        case .movie:
            return MediaViewModel(movie: movies[indexPath.row])
        default:
            return MediaViewModel(tvShow: tv[indexPath.row])
        }
    }
    
    func getMorePage(index: Int) {
        switch typeMedia {
        case .movie:
            let count = movies.count
            if index == count - General.OFFSET {
                page += 1
                movieRepo.updateMovieList(page, path: getPath())
            }
        case .tvShow:
            let count = tv.count
            if index == count - General.OFFSET {
                page += 1
                tvRepo.updateTVShowList(page, path: getPath())
            }
        }
    }
    
    private func getPath() -> String {
        return "/\(Web.VERSION_API)/\(typeMedia.rawValue)/\(filter.rawValue.api)"
    }
}

//MARK: - Movie repository delegate
extension ListingViewModel: MovieRepositoryDelegate {
    
    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateMovieList: [Movie], totalPages: Int) {
        if page <= totalPages {
            if reloadData {
                movies.removeAll()
                reloadData = false
            }
            
            movies.append(contentsOf: didUpdateMovieList)
            delegate?.onListenerMediaList()
        }
    }

    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
}

//MARK: - TV show repository delegate
extension ListingViewModel: TVShowRepositoryDelegate {
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateTVShowList: [TVShow], totalPages: Int) {
        if page <= totalPages {
            if reloadData {
                tv.removeAll()
                reloadData = false
            }
            
            tv.append(contentsOf: didUpdateTVShowList)
            delegate?.onListenerMediaList()
        }
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
}
