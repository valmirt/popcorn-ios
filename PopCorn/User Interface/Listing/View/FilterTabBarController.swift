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
        customize()
        viewControllersParams()
    }
    
    //MARK: - Methods
    func viewControllersParams() {
        let popular = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let popular = popular {
            popular.viewModel = viewModel?.getListingViewModel(by: 0)
        }
        
        let nowPlaying = (viewControllers?[1] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let nowPlaying = nowPlaying {
            nowPlaying.viewModel = viewModel?.getListingViewModel(by: 1)
        }
        
        let topRated = (viewControllers?[2] as? UINavigationController)?.viewControllers[0] as? ListingTableViewController
        if let topRated = topRated {
            topRated.viewModel = viewModel?.getListingViewModel(by: 2)
        }
    }
    
    func customize() {
        let tabBarItemOne = tabBar.items?[0]
        tabBarItemOne?.title = "Popular"
        tabBarItemOne?.image = UIImage(systemName: "heart.fill")
        
        let tabBarItemTwo = tabBar.items?[1]
        tabBarItemTwo?.title = "Now Playing"
        tabBarItemTwo?.image = UIImage(systemName: "pin.fill")
        
        let tabBarItemThree = tabBar.items?[2]
        tabBarItemThree?.title = "Top Rated"
        tabBarItemThree?.image = UIImage(systemName: "star.fill")
    }

}
