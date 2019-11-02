//
//  BaseTabBarController.swift
//  PopCorn
//
//  Created by Valmir Torres on 01/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    internal func customize(tabBar: UITabBar) {
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
