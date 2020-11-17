//
//  DetailTVShowViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol DetailTVShowViewModelDelegate: class {
    func onListenerError(with errorMessage: String)
    func onListenerTVShowDetail()
}

final class DetailTVShowViewModel {
    
    //MARK: - Properties
    private var id: Int
    private var tvRepository: TVShowRepositoryProtocol
    private var tvShow: TVShowDetail?
    weak var delegate: DetailTVShowViewModelDelegate?
    
    var seasonsCount: Int {
        tvShow?.seasons?.count ?? 0
    }
    var creatorsCount: Int {
        tvShow?.createdBy?.count ?? 0
    }
    var title: String {
        tvShow?.name ?? ""
    }
    var genres: String {
        tvShow?.genresFormatted ?? ""
    }
    var countries: String {
        tvShow?.countriesFormatted ?? ""
    }
    var inProduction: String {
        "In Production: \(tvShow?.inProduction ?? false ? "Yes" : "No")"
    }
    var runtime: String {
        "Runtime: \(tvShow?.runTimeFormatted ?? "~") min"
    }
    var numberSeasons: String {
        "Seasons: \(tvShow?.numberOfSeasons ?? 0)"
    }
    var numberEpisodes: String {
        "Episodes: \(tvShow?.numberOfEpisodes ?? 0)"
    }
    
    init(idTV: Int, _ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        id = idTV
        tvRepository = repository
    }
    
    //MARK: - Methods
    func loadData() {
        tvRepository.delegate = self
        tvRepository.detailTVShow(with: id)
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(tvShow?.posterPath ?? "")"
        tvRepository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
    
    func getCreditViewModel(at indexPath: IndexPath) -> CreditViewModel {
        CreditViewModel(creator: tvShow?.createdBy?[indexPath.item])
    }
    
    func getSeasonViewModel(at indexPath: IndexPath) -> SeasonViewModel {
        SeasonViewModel(season: tvShow?.seasons?[indexPath.row])
    }
}

// MARK: - TV show delegate
extension DetailTVShowViewModel: TVShowRepositoryDelegate {
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateTVShowDetail: TVShowDetail) {
        tvShow = didUpdateTVShowDetail
        delegate?.onListenerTVShowDetail()
    }
}
