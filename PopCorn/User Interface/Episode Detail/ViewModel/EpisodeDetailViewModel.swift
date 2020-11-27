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
}
