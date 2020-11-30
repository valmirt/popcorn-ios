//
//  LoadingView.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

import UIKit

final class LoadingView: UIView, CodeView {
    
    //MARK: - View Components
    @ViewCodeComponent
    var loadingContainer: UIView = {
        let view = UIView(frame: .zero)
        view.isOpaque = true
        view.isHidden = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    @ViewCodeComponent
    var loadingSpinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.style = .medium
        indicator.isHidden = true
        indicator.hidesWhenStopped = true
        return indicator
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
        addSubview(loadingContainer)
        loadingContainer.addSubview(loadingSpinner)
    }
    
    func setupConstraints() {
        loadingContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        loadingContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        loadingContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        loadingContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        //Indicator
        loadingSpinner.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        loadingSpinner.topAnchor.constraint(equalTo: loadingContainer.topAnchor, constant: 90).isActive = true
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.systemBackground
    }
}
