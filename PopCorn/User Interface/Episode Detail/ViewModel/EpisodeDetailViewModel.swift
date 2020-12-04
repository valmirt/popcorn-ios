//
//  EpisodeDetailViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol EpisodeDetailViewModelDelegate: AnyObject {
    func onListenerError(with errorMessage: String)
    func onListenerCredit()
}

final class EpisodeDetailViewModel {
    private let episode: Episode?
    private var episodeCredit: Credit?
    private let id: Int
    private var repository: TVShowRepositoryProtocol
    weak var delegate: EpisodeDetailViewModelDelegate?
    
    var title: String {
        episode?.name ?? "Title..."
    }
    var airDate: String {
        "Air Date: \(episode?.airDate ?? "-")"
    }
    var seasonNumber: String {
        "Season number: \(episode?.seasonNumber ?? 0)"
    }
    var episodeNumber: String {
        "Episode number: \(episode?.episodeNumber ?? 0)"
    }
    var overview: String {
        episode?.overview ?? "..."
    }
    var creditCount: Int {
        guard let episodeCredit = episodeCredit else { return 0 }
        return episodeCredit.cast.count + (episodeCredit.guestStars?.count ?? 0) + episodeCredit.crew.count
    }
    
    init(idTVShow: Int, episode: Episode?,_ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.id = idTVShow
        self.episode = episode
        self.repository = repository
    }
    
    func loadData() {
        repository.delegate = self
        repository.episodeCredit(with: id, and: episode?.seasonNumber ?? 0, and: episode?.episodeNumber ?? 0)
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let path = "\(Web.IMAGE_W500)\(episode?.stillPath ?? "")"
        repository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
    
    func getCreditCellViewModel(at indexPath: IndexPath) -> CreditViewModel {
        guard let episodeCredit = episodeCredit else { return CreditViewModel() }
        if indexPath.item < episodeCredit.cast.count {
            return CreditViewModel(cast: episodeCredit.cast[indexPath.item])
        } else {
            let indexOne = indexPath.item - episodeCredit.cast.count
            if indexOne < (episodeCredit.guestStars?.count ?? 0) {
                return CreditViewModel(guestStar: episodeCredit.guestStars![indexOne])
            } else {
                let indexTwo = indexOne - (episodeCredit.guestStars?.count ?? 0)
                return CreditViewModel(crew: episodeCredit.crew[indexTwo])
            }
        }
    }
    
    func getPeopleViewModel(at indexPath: IndexPath) -> PeopleViewModel {
        guard let episodeCredit = episodeCredit else { return PeopleViewModel(id: 0) }
        if indexPath.item < episodeCredit.cast.count {
            return PeopleViewModel(id: episodeCredit.cast[indexPath.item].id)
        } else {
            let indexOne = indexPath.item - episodeCredit.cast.count
            if indexOne < (episodeCredit.guestStars?.count ?? 0) {
                return PeopleViewModel(id: episodeCredit.guestStars![indexOne].id)
            } else {
                let indexTwo = indexOne - (episodeCredit.guestStars?.count ?? 0)
                return PeopleViewModel(id: episodeCredit.crew[indexTwo].id)
            }
        }
    }
}

//MARK: - TV Show repository delegate
extension EpisodeDetailViewModel: TVShowRepositoryDelegate {
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
    
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateEpisodeCredit: Credit) {
        episodeCredit = didUpdateEpisodeCredit
        delegate?.onListenerCredit()
    }
}
