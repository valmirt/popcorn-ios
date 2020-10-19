//
//  SimilarMovieCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 02/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivPoster: UIImageView!
    
    // MARK: - Methods
    func configure(with viewModel: SimilarMovieViewModel?) {
        viewModel?.getImage { (image) in
            self.ivPoster.image = image
        }
    }
    
    // MARK: - IBActions
}

