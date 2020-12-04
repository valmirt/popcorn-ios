//
//  FilmographyCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 03/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class FilmographyCollectionViewCell: UICollectionViewCell, CodeView {
    //MARK: - ViewComponents
    @ViewCodeComponent
    private var posterPathImage: CircleImageView = {
        let imageView = CircleImageView(frame: .zero)
        imageView.borderWidth = 0
        imageView.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.opaqueSeparator
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Super Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    func setupComponents() {
        addSubview(posterPathImage)
    }
    
    func setupConstraints() {
        posterPathImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterPathImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterPathImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        posterPathImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.systemBackground
    }
    
    func configure(with viewModel: FilmographyViewModel?) {
        viewModel?.getImage { image in
            self.posterPathImage.image = image ?? UIImage(systemName: "photo")
        }
    }
}
