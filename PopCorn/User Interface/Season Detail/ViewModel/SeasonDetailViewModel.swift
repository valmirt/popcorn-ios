//
//  SeasonDetailViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 21/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

protocol SeasonDetailViewModelDelegate: AnyObject {
    func onListenerError(with errorMessage: String)
    func onListenerSeasonDetail()
}

final class SeasonDetailViewModel {
    
    //MARK: - Properties
    private let id: Int
    private let seasonNumber: Int
    private var seasonDetail: SeasonDetail?
    private var repository: TVShowRepositoryProtocol
    weak var delegate: SeasonDetailViewModelDelegate?
    
    var title: String {
        seasonDetail?.name ?? "Season Detail"
    }
    var overview: String {
        seasonDetail?.overview ?? "..."
    }
    var airDate: String {
        guard let date = seasonDetail?.airDate else { return "Air Date: -" }
        return "Air Date: \(date)"
    }
    var numberSeason: String {
        "Season Number: \(seasonDetail?.seasonNumber ?? 0)"
    }
    var countEpisodes: Int {
        seasonDetail?.episodes.count ?? 0
    }
    
    init(id: Int, seasonNumber: Int, _ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.id = id
        self.seasonNumber = seasonNumber
        self.repository = repository
    }
    
    //MARK: - Methods
    func loadData() {
        repository.delegate = self
        repository.detailSeason(with: id, and: seasonNumber)
    }
    
    func getEpisodeViewModel(at indexPath: IndexPath) -> EpisodeViewModel {
        EpisodeViewModel(episode: seasonDetail?.episodes[indexPath.row])
    }
    
    func getEpisodeDetailViewModel(at indexPath: IndexPath) -> EpisodeDetailViewModel {
        EpisodeDetailViewModel(episode: seasonDetail?.episodes[indexPath.row])
    }
}

//MARK: - TV show repository delegate
extension SeasonDetailViewModel: TVShowRepositoryDelegate {
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateSeasonDetail: SeasonDetail) {
        seasonDetail = didUpdateSeasonDetail
        delegate?.onListenerSeasonDetail()
    }
}
