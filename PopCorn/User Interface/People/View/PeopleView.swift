//
//  PeopleView.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class PeopleView: UIView, CodeView {
    static let cellIdentifier = "filmographyCell"
    
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
    var imageProfile: CircleImageView = {
        let imageView = CircleImageView(frame: .zero)
        imageView.borderColor = UIColor(named: "Main")!
        imageView.borderWidth = 2
        imageView.cornerRadius = 64
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.opaqueSeparator
        return imageView
    }()
    
    @ViewCodeComponent
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.text = "Profile Name"
        return label
    }()
    
    @ViewCodeComponent
    var birthdayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "★ Birthday: "
        return label
    }()
    
    @ViewCodeComponent
    var deathdayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        label.lineBreakMode = .byTruncatingTail
        label.text = "✟ Deathday: "
        return label
    }()
    
    @ViewCodeComponent
    var departmentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Department: "
        return label
    }()
    
    @ViewCodeComponent
    var popularityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        label.lineBreakMode = .byTruncatingTail
        label.text = "Popularity: "
        return label
    }()
    
    @ViewCodeComponent
    var placeBirthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Place of Birth: "
        return label
    }()
    
    @ViewCodeComponent
    private var biographyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Biography: "
        return label
    }()
    
    @ViewCodeComponent
    var biographyTextView: UITextView = {
        let textview = UITextView(frame: .zero)
        textview.isEditable = false
        textview.textColor = .label
        textview.backgroundColor = UIColor.secondarySystemBackground
        textview.font = UIFont.systemFont(ofSize: 14)
        textview.text = "..."
        return textview
    }()
    
    @ViewCodeComponent
    private var filmographyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Filmography: "
        return label
    }()
    
    @ViewCodeComponent
    var filmographyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmographyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPrefetchingEnabled = true
        collectionView.backgroundColor = UIColor.systemBackground
        return collectionView
    }()
    
    @ViewCodeComponent
    var loadingView: LoadingView = {
        let view = LoadingView()
        return view
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
        contentView.addSubview(imageProfile)
        contentView.addSubview(nameLabel)
        contentView.addSubview(birthdayLabel)
        contentView.addSubview(deathdayLabel)
        contentView.addSubview(departmentLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(placeBirthLabel)
        contentView.addSubview(biographyLabel)
        contentView.addSubview(biographyTextView)
        contentView.addSubview(filmographyLabel)
        contentView.addSubview(filmographyCollectionView)
        contentView.addSubview(loadingView)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        infoProfileConstraints()
        biographyConstraints()
        filmographyConstraints()
        loadingConstraints()
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.systemBackground
    }
    
    //MARK: - Constraint Methods
    private func scrollViewConstraints() {
        //ScrollView
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //ContainerScrollView
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
    private func infoProfileConstraints() {
        //Image Profile
        imageProfile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimens.medium).isActive = true
        imageProfile.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageProfile.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imageProfile.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        //Name
        nameLabel.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: Dimens.big).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.big).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.big).isActive = true
        
        //Birthday
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Dimens.big).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.medium).isActive = true
        birthdayLabel.trailingAnchor.constraint(equalTo: deathdayLabel.trailingAnchor, constant: -Dimens.medium).isActive = true
        
        //Deathday
        deathdayLabel.topAnchor.constraint(equalTo: birthdayLabel.topAnchor).isActive = true
        deathdayLabel.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
        deathdayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.medium).isActive = true
        
        //Department
        departmentLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: Dimens.small).isActive = true
        departmentLabel.leadingAnchor.constraint(equalTo: birthdayLabel.leadingAnchor).isActive = true
        departmentLabel.trailingAnchor.constraint(equalTo: deathdayLabel.trailingAnchor).isActive = true
        
        //Popularity
        popularityLabel.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: Dimens.small).isActive = true
        popularityLabel.leadingAnchor.constraint(equalTo: departmentLabel.leadingAnchor).isActive = true
        popularityLabel.trailingAnchor.constraint(equalTo: departmentLabel.trailingAnchor).isActive = true
        
        //Place of Birth
        placeBirthLabel.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: Dimens.small).isActive = true
        placeBirthLabel.leadingAnchor.constraint(equalTo: popularityLabel.leadingAnchor).isActive = true
        placeBirthLabel.trailingAnchor.constraint(equalTo: popularityLabel.trailingAnchor).isActive = true
    }
    
    private func biographyConstraints() {
        //Label
        biographyLabel.topAnchor.constraint(equalTo: placeBirthLabel.bottomAnchor, constant: Dimens.medium).isActive = true
        biographyLabel.leadingAnchor.constraint(equalTo: placeBirthLabel.leadingAnchor).isActive = true
        biographyLabel.trailingAnchor.constraint(equalTo: placeBirthLabel.trailingAnchor).isActive = true
        
        //TextView
        biographyTextView.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: Dimens.little).isActive = true
        biographyTextView.leadingAnchor.constraint(equalTo: biographyLabel.leadingAnchor).isActive = true
        biographyTextView.trailingAnchor.constraint(equalTo: biographyLabel.trailingAnchor).isActive = true
        biographyTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func filmographyConstraints() {
        //Label
        filmographyLabel.topAnchor.constraint(equalTo: biographyTextView.bottomAnchor, constant: Dimens.medium).isActive = true
        filmographyLabel.leadingAnchor.constraint(equalTo: biographyTextView.leadingAnchor).isActive = true
        filmographyLabel.trailingAnchor.constraint(equalTo: biographyTextView.trailingAnchor).isActive = true
        
        //List
        filmographyCollectionView.topAnchor.constraint(equalTo: filmographyLabel.bottomAnchor, constant: Dimens.little).isActive = true
        filmographyCollectionView.leadingAnchor.constraint(equalTo: filmographyLabel.leadingAnchor).isActive = true
        filmographyCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filmographyCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimens.medium).isActive = true
        filmographyCollectionView.heightAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    private func loadingConstraints() {
        loadingView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
