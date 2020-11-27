//
//  EpisodeViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 24/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeViewModel {
    private let episode: Episode?
    private var repository: TVShowRepositoryProtocol
    
    var title: String {
        episode?.name ?? ""
    }
    var overview: String {
        episode?.overview ?? "..."
    }
    
    init(episode: Episode?, repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.episode = episode
        self.repository = repository
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let path = "\(Web.IMAGE_W342)\(episode?.stillPath ?? "")"
        repository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
}
