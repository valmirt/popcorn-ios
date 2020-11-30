//
//  PeopleCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class PeopleCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var viewModel: PeopleViewModel?
    
    init(navigationController: UINavigationController, viewModel: PeopleViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let peopleVC = PeopleViewController()
        peopleVC.coordinator = self
        peopleVC.viewModel = viewModel
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationController.navigationBar.topItem?.backBarButtonItem = backItem
        navigationController.pushViewController(peopleVC, animated: true)
    }
    
    deinit {
        print("PeopleCoordinator free")
    }
}

extension PeopleCoordinator: PeoplePresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?) {
        
    }
    
    func showDetailTVShow(with viewModel: DetailTVShowViewModel?) {
        
    }
    
    func exitThisScreen() {
        
    }
}
