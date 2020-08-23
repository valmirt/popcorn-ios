//
//  HomeViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 06/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
        viewControllersParams()
    }
    
    func customize() {
        let tabBarItemOne = tabBar.items?[0]
        tabBarItemOne?.title = "Movies"
        tabBarItemOne?.image = UIImage(systemName: "film")
        
        let tabBarItemTwo = tabBar.items?[1]
        tabBarItemTwo?.title = "Tv Shows"
        tabBarItemTwo?.image = UIImage(systemName: "tv")
    }
    
    func viewControllersParams() {
        let movie = self.viewControllers?[0] as? GenericTabBarController
        if let movie = movie {
            movie.type = .movie
        }
        let tv = self.viewControllers?[1] as? GenericTabBarController
        if let tv = tv {
            tv.type = .tvShow
        }
    }
}

