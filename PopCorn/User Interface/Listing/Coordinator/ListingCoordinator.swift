//
//  ListingCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class ListingCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    deinit {
        print("ListingCoordinator free.")
    }
}

extension ListingCoordinator: DetailMediaPresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?) {
        let coordinator = DetailMovieCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
    
    func showDetailTVShow(with viewModel: DetailTVShowViewModel?) {
        let coordinator = DetailTVShowCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
