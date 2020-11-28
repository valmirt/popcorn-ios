//
//  EpisodeDetailViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeDetailViewModel {
    private let episode: Episode?
    private var repository: TVShowRepositoryProtocol
    
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
        guard let episode = episode else { return 0 }
        return episode.guestStars.count + episode.crew.count
    }
    
    init(episode: Episode?,_ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.episode = episode
        self.repository = repository
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let path = "\(Web.IMAGE_W500)\(episode?.stillPath ?? "")"
        repository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
    
    func getCreditCellViewModel(at indexPath: IndexPath) -> CreditViewModel {
        guard let episode = episode else { return CreditViewModel() }
        let credit = Credit(id: 0, cast: episode.guestStars, crew: episode.crew)
        if indexPath.item < credit.cast.count {
            return CreditViewModel(cast: credit.cast[indexPath.item])
        } else {
            let index = indexPath.item - credit.cast.count
            return CreditViewModel(crew: credit.crew[index])
        }
    }
}
