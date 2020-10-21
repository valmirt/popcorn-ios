//
//  SearchViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    var coordinator: Coordinator?
    var viewModel: SearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
    }
}
