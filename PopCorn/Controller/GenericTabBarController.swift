//
//  GenericTabBarController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class GenericTabBarController: UITabBarController {
    var type: String = "movie"
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
        viewControllersParams()
    }
    
    
    func viewControllersParams() {
        let popular = self.viewControllers?[0] as? NavViewController
        if let popular = popular {
            popular.type = type
            popular.filter = "popular"
        }
        
        let nowPlaying = self.viewControllers?[1] as? NavViewController
        if let nowPlaying = nowPlaying {
            nowPlaying.type = type
            nowPlaying.filter = "now_playing"
        }
        
        let topRated = self.viewControllers?[2] as? NavViewController
        if let topRated = topRated {
            topRated.type = type
            topRated.filter = "top_rated"
        }
    }
    
    internal func customize() {
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
