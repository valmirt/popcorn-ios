//
//  BaseTableViewCell.swift
//  PopCorn
//
//  Created by Valmir Torres on 01/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class MediaTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var releaseLabel: UILabel?
    @IBOutlet weak var popularLabel: UILabel?
    @IBOutlet weak var rateLabel: UILabel?

    //MARK: - Methods
    
    func configure(with viewModel: MediaViewModel?) {
        titleLabel?.text = viewModel?.title
        releaseLabel?.text = viewModel?.releaseDate
        popularLabel?.text = viewModel?.popular
        rateLabel?.text = viewModel?.rate
        
        viewModel?.getImage(onComplete: { (image) in
            self.posterImageView?.image = image
        })
    }
}
