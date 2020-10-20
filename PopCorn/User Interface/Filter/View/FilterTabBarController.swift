//
//  FilterTabBarController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class FilterTabBarController: UITabBarController {
    //MARK: - Propertiesb
    var viewModel: FilterViewModel?
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Methods
    private func setupView() {
        let popular = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let popular = popular {
            popular.viewModel = viewModel?.getListingViewModel(by: 0)
            popular.tabBarItem = UITabBarItem(title: "Popular", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        }
        
        let nowPlaying = (viewControllers?[1] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let nowPlaying = nowPlaying {
            nowPlaying.viewModel = viewModel?.getListingViewModel(by: 1)
            nowPlaying.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "pin.fill"), selectedImage: UIImage(systemName: "pin.fill"))
        }
        
        let topRated = (viewControllers?[2] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let topRated = topRated {
            topRated.viewModel = viewModel?.getListingViewModel(by: 2)
            topRated.tabBarItem = UITabBarItem(title: "Top Rated", image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
        }
    }
}
