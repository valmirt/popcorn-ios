//
//  DetailMovieViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol DetailMovieViewModelDelegate: class {
    func onListenerError(with errorMessage: String)
    func onListenerDetailMovie()
    func onListenerCredit()
    func onListenerSimilarMovies()
}

final class DetailMovieViewModel {
    //MARK: - Properties
    private var id: Int
    private var page = Constants.General.FIRST
    private lazy var movieRepo: MovieRepositoryProtocol = MovieRepository()
    private var credit: Credit?
    private var similarMovies: [Movie] = []
    private var movie: MovieDetail?
    weak var delegate: DetailMovieViewModelDelegate?
    
    var creditCount: Int {
        guard let credit = credit else { return 0 }
        return credit.cast.count + credit.crew.count
    }
    var similarMoviesCount: Int {
        similarMovies.count
    }
    var title: String {
        movie?.title ?? ""
    }
    var genres: String {
        movie?.genresFormatted ?? ""
    }
    var countries: String {
        movie?.countriesFormatted ?? ""
    }
    var status: String {
        movie?.status ?? ""
    }
    var date: String {
        movie?.yearDate ?? ""
    }
    var runtime: String {
        "\(String(movie?.runtime ?? 0)) min"
    }
    var overview: String {
        movie?.overview ?? ""
    }
    var companies: String {
        movie?.companiesFormatted ?? ""
    }
    
    init(idMovie: Int) {
        id = idMovie
    }
    
    //MARK: - Methods
    func loadData() {
        movieRepo.delegate = self
        
        movieRepo.detailMovie(with: id)
        movieRepo.creditMovie(with: id)
        movieRepo.updateSimilarMovies(with: id, page)
    }
    
    func getMorePages(at indexPath: IndexPath) {
        let count = similarMovies.count
        if indexPath.item == count - Constants.General.OFFSET {
            page += 1
            movieRepo.updateSimilarMovies(with: id, page)
            print(page)
        }
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(movie?.posterPath ?? "")"
        movieRepo.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
    
    func getCreditCellViewModel(at indexPath: IndexPath) -> CreditViewModel {
        if let credit = credit {
            if indexPath.item < credit.cast.count {
                return CreditViewModel(cast: credit.cast[indexPath.item])
            } else {
                let index = indexPath.item - credit.cast.count
                return CreditViewModel(crew: credit.crew[index])
            }
        }
        
        return CreditViewModel()
    }
    
    func getSimilarMovieViewModel(at indexPath: IndexPath) -> SimilarMovieViewModel {
        SimilarMovieViewModel(movie: similarMovies[indexPath.item])
    }
    
    func getDetailViewModel(at indexPath: IndexPath) -> DetailMovieViewModel {
        DetailMovieViewModel(idMovie: similarMovies[indexPath.item].id)
    }
}

//MARK: - Movie Repository delegate
extension DetailMovieViewModel: MovieRepositoryDelegate {
    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
    
    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateMovieDetail: MovieDetail) {
        movie = didUpdateMovieDetail
        delegate?.onListenerDetailMovie()
    }
    
    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateCreditMovie: Credit) {
        credit = didUpdateCreditMovie
        delegate?.onListenerCredit()
    }
    
    func movieRepository(_ manager: MovieRepositoryProtocol, didUpdateSimilarMovies: [Movie], totalPages: Int) {
        if page < totalPages {
            similarMovies.append(contentsOf: didUpdateSimilarMovies)
            delegate?.onListenerSimilarMovies()
        }
    }
}
