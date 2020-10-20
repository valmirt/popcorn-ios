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
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var ivPoster: CircleImageView!
    
    // MARK: - Methods
    func configure(with viewModel: SeasonViewModel?) {
        lbTitle.text = viewModel?.title
        lbOverview.text = viewModel?.overview
        viewModel?.getImage(onComplete: { (image) in
            self.ivPoster.image = image
        })
    }
}

