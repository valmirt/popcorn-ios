//
//  EpisodeTableViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 24/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell, CodeView {
    //MARK: - View Components
    @ViewCodeComponent
    private var posterImageView: CircleImageView = {
        let imageView = CircleImageView(frame: .zero)
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 4
        imageView.tintColor = UIColor.opaqueSeparator
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    @ViewCodeComponent
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    @ViewCodeComponent
    private var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    //MARK: - Super Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    func configure(with viewModel: EpisodeViewModel?) {
        titleLabel.text = viewModel?.title
        overviewLabel.text = viewModel?.overview
        viewModel?.getImage { image in
            if image != nil {
                self.posterImageView.contentMode = .scaleAspectFill
                self.posterImageView.image = image
            } else {
                self.posterImageView.contentMode = .scaleToFill
                self.posterImageView.image = UIImage(systemName: "photo")
            }
        }
    }
    
    func setupComponents() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimens.minimum).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimens.minimum).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Dimens.little).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -Dimens.little).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.minimum).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Dimens.minimum).isActive = true
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.systemBackground
        accessoryType = .detailButton
    }
}
