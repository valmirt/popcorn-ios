//
//  CreditViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class CreditViewModel {
    // MARK: - Properties
    private let movieRepository: MovieRepositoryProtocol
    private let cast: Cast?
    private let crew: Crew?
    private let creator: Creator?
    
    init(cast: Cast? = nil, crew: Crew? = nil, creator: Creator? = nil, repository: MovieRepositoryProtocol = MovieRepository()) {
        self.cast = cast
        self.crew = crew
        self.creator = creator
        self.movieRepository = repository
    }
    
    var name: String {
        cast?.name ?? crew?.name ?? creator?.name ?? ""
    }
    
    var charOrJob: String {
        cast?.character ?? crew?.job ?? ""
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let completePath = "\(Web.IMAGE_W185)\(cast?.profilePath ?? crew?.profilePath ?? creator?.profilePath ?? "")"
        movieRepository.updateImage(baseURL: base, path: completePath) { image in
            onComplete(image)
        }
    }
}
