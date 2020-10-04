//
//  CreditCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 28/09/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class CreditCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var movieRepository: MovieRepository = ProdMovieRepository()
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivProfilePicture: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelChar: UILabel!
    
    // MARK: - Super Methods
    
    // MARK: - Methods
    func fillCell(with cast: Cast) {
        labelName.text = cast.name
        labelChar.text = cast.character
        setImage(with: cast.profilePath)
    }
    
    func fillCell(with crew: Crew) {
        labelName.text = crew.name
        labelChar.text = crew.job
        setImage(with: crew.profilePath)
    }
    
    func fillCell(with creator: Creator) {
        labelName.text = creator.name
        labelChar.isHidden = true
        setImage(with: creator.profilePath)
    }
    
    func setImage(with path: String?) {
        if let path = path {
            let base = Constants.Web.BASE_URL_IMAGE
            let completePath = "\(Constants.Web.IMAGE_W185)\(path)"
            movieRepository.updateImage(baseURL: base, path: completePath) { image in
                self.ivProfilePicture.image = image
            }
        }
    }
}
