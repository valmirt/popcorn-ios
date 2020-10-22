//
//  DetailMovieCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class DetailMovieCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let viewModel: DetailMovieViewModel?
    
    init(navigationController: UINavigationController, viewModel: DetailMovieViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let detailVC = DetailMovieViewController.instatiate(from: .detailMovie)
        detailVC.viewModel = viewModel
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        print("DetailMovieCoordinator free")
    }
}

extension DetailMovieCoordinator: DetailMoviePresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?) {
        let coordinator = DetailMovieCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
