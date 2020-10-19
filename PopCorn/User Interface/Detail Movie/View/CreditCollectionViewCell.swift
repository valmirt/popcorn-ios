//
//  CreditCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 28/09/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class CreditCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivProfilePicture: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelChar: UILabel!
    
    // MARK: - Super Methods
    
    // MARK: - Methods
    func configure(with viewModel: CreditViewModel?) {
        labelName.text = viewModel?.name
        if viewModel?.charOrJob.isEmpty ?? true {
            labelChar.isHidden = true
        }
        labelChar.text = viewModel?.charOrJob
        viewModel?.getImage(onComplete: { (image) in
            if let image = image {
                self.ivProfilePicture.image = image
            } else {
                self.ivProfilePicture.image = UIImage(systemName: "person.fill")
            }
        })
    }
}
