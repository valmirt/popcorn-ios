//
//  EpisodeDetailCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var viewModel: EpisodeDetailViewModel?
    
    
    init(navigationController: UINavigationController, viewModel: EpisodeDetailViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        
    }
    
    deinit {
        print("EpisodeDetailCoordinator free")
    }
}
