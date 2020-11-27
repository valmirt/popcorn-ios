//
//  SeasonDetailCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 21/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SeasonDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var viewModel: SeasonDetailViewModel?
    
    init(navigationController: UINavigationController, viewModel: SeasonDetailViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let seasonVC = SeasonDetailViewController()
        seasonVC.coordinator = self
        seasonVC.viewModel = viewModel
        navigationController.pushViewController(seasonVC, animated: true)
    }
    
    deinit {
        print("SeasonDetailCoordinator free")
    }
}

extension SeasonDetailCoordinator: SeasonDetailPresenter {
    func showEpisodeDetail(with viewModel: EpisodeDetailViewModel?) {
        let coordinator = EpisodeDetailCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
    
    func exitThisScreen() {
        navigationController.popViewController(animated: true)
    }
}
