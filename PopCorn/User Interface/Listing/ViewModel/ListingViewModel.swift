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
    var typeMedia: TypeContent
    var filter: FilterContent
    lazy var movieRepo: MovieRepositoryProtocol = MovieRepository()
    lazy var tvRepo: TVShowRepositoryProtocol = TVShowRepository()
    lazy var movies: [Movie] = []
    lazy var tv: [TVShow] = []
    private var page = Constants.General.FIRST
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
    
    init(typeMedia: TypeContent, filter: FilterContent) {
        self.typeMedia = typeMedia
        self.filter = filter
    }
    
    //MARK: - Methods
    func loadData() {
        page = Constants.General.FIRST
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
    
    private func getPath() -> String {
        return "/\(Constants.Web.VERSION_API)/\(typeMedia.rawValue)/\(filter.rawValue.api)"
    }
    
    func getDetailMovieViewModel(at indexPath: IndexPath) -> DetailMovieViewModel {
        DetailMovieViewModel(idMovie: movies[indexPath.row].id)
    }
    
    func getDetailTVShowViewModel(at indexPath: IndexPath) -> DetailTVShowViewModel {
        DetailTVShowViewModel(idTV: tv[indexPath.row].id)
    }
    
    func getMorePage(index: Int) {
        switch typeMedia {
        case .movie:
            let count = movies.count
            if index == count - Constants.General.OFFSET {
                page += 1
                movieRepo.updateMovieList(page, path: getPath())
            }
        case .tvShow:
            let count = tv.count
            if index == count - Constants.General.OFFSET {
                page += 1
                tvRepo.updateTVShowList(page, path: getPath())
            }
        }
    }
    
    func getMediaViewModel(at indexPath: IndexPath) -> MediaViewModel {
        switch typeMedia {
        case .movie:
            return MediaViewModel(movie: movies[indexPath.row])
        default:
            return MediaViewModel(tvShow: tv[indexPath.row])
        }
    }
}

//MARK: - Movie repository delegate
extension ListingViewModel: MovieRepositoryDelegate {
    
    func movieRepository(_ manager: MovieRepository, didUpdateMovieList: [Movie], totalPages: Int) {
        if page < totalPages {
            if reloadData {
                movies.removeAll()
                reloadData = false
            }
            
            movies.append(contentsOf: didUpdateMovieList)
            delegate?.onListenerMediaList()
        }
    }

    func movieRepository(_ manager: MovieRepository, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
}

//MARK: - TV show repository delegate
extension ListingViewModel: TVShowRepositoryDelegate {
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateTVShowList: [TVShow], totalPages: Int) {
        if page < totalPages {
            if reloadData {
                tv.removeAll()
                reloadData = false
            }
            
            tv.append(contentsOf: didUpdateTVShowList)
            delegate?.onListenerMediaList()
        }
    }
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
}
