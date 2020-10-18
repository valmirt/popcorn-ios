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
        customize()
        viewControllersParams()
    }
    
    //MARK: - Methods
    func customize() {
        let tabBarItemOne = tabBar.items?[0]
        tabBarItemOne?.title = "Movies"
        tabBarItemOne?.image = UIImage(systemName: "film")
        
        let tabBarItemTwo = tabBar.items?[1]
        tabBarItemTwo?.title = "Tv Shows"
        tabBarItemTwo?.image = UIImage(systemName: "tv")
    }
    
    func viewControllersParams() {
        let firstTabBarController = viewControllers?[0] as? FilterTabBarController
        if let firstTabBarController = firstTabBarController {
            firstTabBarController.viewModel = viewModel.getFilterViewModel(isMovie: true)
        }
        let secondTabBarController = viewControllers?[1] as? FilterTabBarController
        if let secondTabBarController = secondTabBarController {
            secondTabBarController.viewModel = viewModel.getFilterViewModel(isMovie: false)
        }
    }
}

