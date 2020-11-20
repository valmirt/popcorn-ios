//
//  SeasonViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SeasonViewModel {
    private let tvRepository: TVShowRepositoryProtocol
    private let season: Season?
    
    var title: String {
        season?.name ?? ""
    }
    var overview: String {
        season?.overview ?? ""
    }
    
    init(season: Season?, _ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.season = season
        tvRepository = repository
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let path = "\(Web.IMAGE_W342)\(season?.posterPath ?? "")"
        tvRepository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
}
