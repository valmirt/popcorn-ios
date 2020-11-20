//
//  DetailTVShowCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class DetailTVShowCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let viewModel: DetailTVShowViewModel?
    
    init(navigationController: UINavigationController, viewModel: DetailTVShowViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let detailVC = DetailTVShowViewController.instatiate(from: .detailTVShow)
        detailVC.viewModel = viewModel
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        print("DetailTVShowCoordinator free")
    }
}

extension DetailTVShowCoordinator: DetailTVShowPresenter {
    func showSeasonDetail(with viewModel: SeasonDetailViewModel?) {
        let coordinator = SeasonDetailCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
