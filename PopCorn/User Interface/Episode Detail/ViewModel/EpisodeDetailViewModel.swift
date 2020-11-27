//
//  EpisodeDetailViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

final class EpisodeDetailViewModel {
    private let episode: Episode?
    private var repository: TVShowRepositoryProtocol
    
    init(episode: Episode?,_ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.episode = episode
        self.repository = repository
    }
}
