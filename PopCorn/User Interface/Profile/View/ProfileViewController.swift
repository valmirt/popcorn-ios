//
//  ProfileViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var coordinator: Coordinator?
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
    }
}
