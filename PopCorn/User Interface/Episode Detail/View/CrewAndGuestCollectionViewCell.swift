//
//  CrewAndGuestCollectionViewCell.swift
//  PopCorn
//
//  Created by Valmir Junior on 28/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class CrewAndGuestCollectionViewCell: UICollectionViewCell, CodeView {
    //MARK: - ViewComponents
    @ViewCodeComponent
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    private var labelChar: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    @ViewCodeComponent
    private var ivProfilePicture: CircleImageView = {
        let imageView = CircleImageView(frame: .zero)
        imageView.borderWidth = 1
        imageView.borderColor = UIColor(named: "Main")!
        imageView.cornerRadius = 32
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    func setupComponents() {
        contentView.addSubview(ivProfilePicture)
        contentView.addSubview(labelName)
        contentView.addSubview(labelChar)
    }
    
    func setupConstraints() {
        //Image
        ivProfilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimens.minimum).isActive = true
        ivProfilePicture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ivProfilePicture.heightAnchor.constraint(equalToConstant: 64).isActive = true
        ivProfilePicture.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        //Name
        labelName.topAnchor.constraint(equalTo: ivProfilePicture.bottomAnchor, constant: Dimens.little).isActive = true
        labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.little).isActive = true
        labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.little).isActive = true
        
        //Char
        labelChar.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: Dimens.minimum).isActive = true
        labelChar.leadingAnchor.constraint(equalTo: labelName.leadingAnchor).isActive = true
        labelChar.trailingAnchor.constraint(equalTo: labelName.trailingAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        contentView.backgroundColor = UIColor(named: "BackgroundModal")
    }
}
