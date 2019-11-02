//
//  MovieTabBarController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class MovieTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customize(tabBar: self.tabBar)
        viewControllersParams()
    }
    
    
    func viewControllersParams() {
        let popular = self.viewControllers?[0] as? NavViewController
        if let popular = popular {
            popular.type = "movie"
            popular.filter = "popular"
        }
        
        let nowPlaying = self.viewControllers?[1] as? NavViewController
        if let nowPlaying = nowPlaying {
            nowPlaying.type = "movie"
            nowPlaying.filter = "now_playing"
        }
        
        let topRated = self.viewControllers?[2] as? NavViewController
        if let topRated = topRated {
            topRated.type = "movie"
            topRated.filter = "top_rated"
        }
    }

}
