//
//  EpisodeDetailView.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeDetailView: UIView, CodeView {
    static let cellIdentifier = "creditCell"
    
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
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var seasonNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Season number: "
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var episodeNumberLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.text = "Episode number: "
        label.font = .preferredFont(forTextStyle: .subheadline)
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
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    private var containerOverviewAndCrew: UIView = {
        let content = UIView(frame: .zero)
        content.backgroundColor = UIColor(named: "BackgroundModal")
        return content
    }()
    
    @ViewCodeComponent
    private var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Overview: "
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var overviewTextView: UITextView = {
        let textview = UITextView(frame: .zero)
        textview.isEditable = false
        textview.textColor = .label
        textview.backgroundColor = UIColor.secondarySystemBackground
        textview.font = UIFont.systemFont(ofSize: 14)
        textview.text = "..."
        return textview
    }()
    
    @ViewCodeComponent
    private var crewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Casting & Crew: "
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    var creditCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: 120, height: 145)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CrewAndGuestCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPrefetchingEnabled = true
        collectionView.backgroundColor = UIColor(named: "BackgroundModal")
        return collectionView
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
        contentView.addSubview(containerOverviewAndCrew)
        containerOverviewAndCrew.addSubview(overviewLabel)
        containerOverviewAndCrew.addSubview(overviewTextView)
        containerOverviewAndCrew.addSubview(crewLabel)
        containerOverviewAndCrew.addSubview(creditCollectionView)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        backdropImageConstraints()
        infoConstraints()
        containerOverviewAndCrewConstraints()
        overviewConstraints()
        creditConstraints()
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
    
    private func containerOverviewAndCrewConstraints() {
        containerOverviewAndCrew.topAnchor.constraint(equalTo: episodeNumberLabel.bottomAnchor, constant: Dimens.medium).isActive = true
        containerOverviewAndCrew.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerOverviewAndCrew.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerOverviewAndCrew.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func overviewConstraints() {
        //Label
        overviewLabel.topAnchor.constraint(equalTo: containerOverviewAndCrew.topAnchor, constant: Dimens.medium).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: containerOverviewAndCrew.leadingAnchor, constant: Dimens.medium).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: containerOverviewAndCrew.trailingAnchor, constant: -Dimens.medium).isActive = true
        
        //TextView
        overviewTextView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Dimens.little).isActive = true
        overviewTextView.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor).isActive = true
        overviewTextView.trailingAnchor.constraint(equalTo: overviewLabel.trailingAnchor).isActive = true
        overviewTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func creditConstraints() {
        //Label
        crewLabel.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: Dimens.medium).isActive = true
        crewLabel.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor).isActive = true
        crewLabel.trailingAnchor.constraint(equalTo: overviewLabel.trailingAnchor).isActive = true
        
        //CreditList
        creditCollectionView.topAnchor.constraint(equalTo: crewLabel.bottomAnchor, constant: Dimens.little).isActive = true
        creditCollectionView.leadingAnchor.constraint(equalTo: crewLabel.leadingAnchor).isActive = true
        creditCollectionView.trailingAnchor.constraint(equalTo: crewLabel.trailingAnchor).isActive = true
        creditCollectionView.bottomAnchor.constraint(equalTo: containerOverviewAndCrew.bottomAnchor, constant: -Dimens.big).isActive = true
        creditCollectionView.heightAnchor.constraint(equalToConstant: 156).isActive = true
    }
}
