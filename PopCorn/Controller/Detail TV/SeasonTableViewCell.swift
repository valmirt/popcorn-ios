//
//  SeasonTableViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 04/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

import UIKit

final class SeasonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var tvRepository: TVShowRepository = ProdTVShowRepository()
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var ivPoster: CircleImageView!
    
    // MARK: - Methods
    func fillCell(with data: Season) {
        lbTitle.text = data.name
        lbOverview.text = data.overview
        if let poster = data.posterPath {
            setImage(with: poster)
        }
    }
    
    private func setImage(with poster: String) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(poster)"
        tvRepository.updateImage(baseURL: base, path: path) { image in
            self.ivPoster.image = image
        }
    }
}

