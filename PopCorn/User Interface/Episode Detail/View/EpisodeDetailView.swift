//
//  EpisodeDetailView.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeDetailView: UIView, CodeView {
    
    //MARK: - View Components
    @ViewCodeComponent
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    @ViewCodeComponent
    private var contentView: UIView = {
        let content = UIView(frame: .zero)
        return content
    }()
    
    @ViewCodeComponent
    var backdropImage: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor.opaqueSeparator
        image.clipsToBounds = true
        return image
    }()
    
    @ViewCodeComponent
    private var gradientImage: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.image = UIImage(named: "gradient")
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor.opaqueSeparator
        image.clipsToBounds = true
        return image
    }()
    
    @ViewCodeComponent
    var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Title"
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var seasonNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Season number: "
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var episodeNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Episode number: "
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var airDateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Air Date: "
        label.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    private var overviewAndLists: UIView = {
        let content = UIView(frame: .zero)
        content.backgroundColor = UIColor(named: "BackgroundModal")
        return content
    }()
    
    //MARK: - Super Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    //MARK: - Methods
    func setupComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImage)
        contentView.addSubview(gradientImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(seasonNumberLabel)
        contentView.addSubview(episodeNumberLabel)
        contentView.addSubview(airDateLabel)
        contentView.addSubview(overviewAndLists)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        backdropImageConstraints()
        infoConstraints()
        overviewAndListConstraints()
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.black
    }
    
    //MARK: - Constraint Methods
    private func scrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func contentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
    private func backdropImageConstraints() {
        //Image
        backdropImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backdropImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backdropImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backdropImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        //Gradient
        gradientImage.leadingAnchor.constraint(equalTo: backdropImage.leadingAnchor).isActive = true
        gradientImage.trailingAnchor.constraint(equalTo: backdropImage.trailingAnchor).isActive = true
        gradientImage.bottomAnchor.constraint(equalTo: backdropImage.bottomAnchor).isActive = true
        gradientImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func infoConstraints() {
        //Title
        titleLabel.topAnchor.constraint(equalTo: backdropImage.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backdropImage.leadingAnchor, constant: Dimens.medium).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backdropImage.trailingAnchor, constant: -Dimens.medium).isActive = true
        
        //Season Number
        seasonNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.small).isActive = true
        seasonNumberLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        seasonNumberLabel.trailingAnchor.constraint(equalTo: airDateLabel.leadingAnchor, constant: -Dimens.medium).isActive = true
        
        //Air Date
        airDateLabel.topAnchor.constraint(equalTo: seasonNumberLabel.topAnchor).isActive = true
        airDateLabel.bottomAnchor.constraint(equalTo: seasonNumberLabel.bottomAnchor).isActive = true
        airDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        //Episode Number
        episodeNumberLabel.topAnchor.constraint(equalTo: seasonNumberLabel.bottomAnchor, constant: Dimens.small).isActive = true
        episodeNumberLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        episodeNumberLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func overviewAndListConstraints() {
        overviewAndLists.topAnchor.constraint(equalTo: episodeNumberLabel.bottomAnchor, constant: Dimens.medium).isActive = true
        overviewAndLists.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        overviewAndLists.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        overviewAndLists.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        overviewAndLists.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
}
