//
//  NavViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 01/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {
    var type: TypeContent = .movie
    var filter: FilterContent = .popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dest = self.viewControllers[0] as? GenericTableViewController
        dest?.type = type
        dest?.filter = filter
    }

}
