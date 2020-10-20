//
//  HomeViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class HomeTabBarController: UITabBarController {
    
    let viewModel = HomeViewModel()
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Methods
    private func setupView() {
        let firstTabBarController = viewControllers?[0] as? FilterTabBarController
        if let firstTabBarController = firstTabBarController {
            firstTabBarController.viewModel = viewModel.getFilterViewModel(isMovie: true)
            firstTabBarController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film"))
        }
        let secondTabBarController = viewControllers?[1] as? FilterTabBarController
        if let secondTabBarController = secondTabBarController {
            secondTabBarController.viewModel = viewModel.getFilterViewModel(isMovie: false)
            secondTabBarController.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv"))
        }
    }
}

