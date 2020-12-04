//
//  FilmographyViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 03/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class FilmographyViewModel {
    private let credited: CreditedFilmography?
    private let repository: MovieRepositoryProtocol
    
    init(credited: CreditedFilmography?, _ repository: MovieRepositoryProtocol = MovieRepository()) {
        self.credited = credited
        self.repository = repository
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let completePath = "\(Web.IMAGE_W185)\(credited?.posterPath ?? "")"
        repository.updateImage(baseURL: base, path: completePath) { image in
            onComplete(image)
        }
    }
}
