//
//  SeasonViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SeasonViewModel {
    private lazy var tvRepository: TVShowRepositoryProtocol = TVShowRepository()
    private let season: Season?
    
    var title: String {
        season?.name ?? ""
    }
    var overview: String {
        season?.overview ?? ""
    }
    
    init(season: Season?) {
        self.season = season
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(season?.posterPath ?? "")"
        tvRepository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
}
