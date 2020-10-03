//
//  SimilarMovieCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 02/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var movieRepository: MovieRepository = ProdMovieRepository()
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivPoster: UIImageView!
    
    // MARK: - Methods
    func fillCell(with data: Movie) {
        setImage(with: data.posterPath)
    }
    
    func setImage(with path: String?) {
        if let path = path {
            let base = Constants.Web.BASE_URL_IMAGE
            let completePath = "\(Constants.Web.IMAGE_W185)\(path)"
            movieRepository.updateImage(baseURL: base, path: completePath) { image in
                self.ivPoster.image = image
            }
        }
    }
    
    // MARK: - IBActions
}

