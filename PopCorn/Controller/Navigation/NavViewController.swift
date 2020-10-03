//
//  NavViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 01/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class NavViewController: UINavigationController {
    //MARK: - Properties
    var type: TypeContent = .movie
    var filter: FilterContent = .popular
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let dest = self.viewControllers[0] as? GenericTableViewController
        dest?.type = type
        dest?.filter = filter
    }

}
