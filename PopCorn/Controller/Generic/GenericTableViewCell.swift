//
//  BaseTableViewCell.swift
//  PopCorn
//
//  Created by Valmir Torres on 01/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class GenericTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var movie: Movie?
    var tv: TVShow?
    
    //MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var releaseLabel: UILabel?
    @IBOutlet weak var popularLabel: UILabel?
    @IBOutlet weak var rateLabel: UILabel?

    //MARK: - Methods
    func setImage(_ image: UIImage?) {
        posterImageView?.image = image
    }
    
    func setValues() {
        DispatchQueue.main.async {
            if let safeMovie = self.movie {
                self.titleLabel?.text = safeMovie.title
                self.releaseLabel?.text = String(safeMovie.releaseDate.prefix(4))
                self.popularLabel?.text = String(format: "%.1f", safeMovie.popularity)
                self.rateLabel?.text = String(format: "%.1f", safeMovie.voteAverage)
            } else if let safeTV = self.tv {
                self.titleLabel?.text = safeTV.name
                self.releaseLabel?.text = String(safeTV.firstAirDate.prefix(4))
                self.popularLabel?.text = String(format: "%.1f", safeTV.popularity)
                self.rateLabel?.text = String(format: "%.1f", safeTV.voteAverage)
            }
        }
    }
}
