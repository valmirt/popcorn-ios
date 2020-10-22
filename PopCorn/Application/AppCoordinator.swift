//
//  AppCoordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var homeTabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        homeTabBarController = UITabBarController()
    }
    
    func start() {
        let homeBarItems: [HomeTabBar] = [.movies, .tvShow, .profile, .search].sorted(by: { $0.order < $1.order })
        let navControllers = homeBarItems.map { prepareHomeNavigationController(with: $0) }
        homeTabBarController.setViewControllers(navControllers, animated: true)
        navigationController.pushViewController(homeTabBarController, animated: false)
    }
    
    private func prepareHomeNavigationController(with homeTabBar: HomeTabBar) -> UINavigationController {
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.isHidden = homeTabBar.navIsHidden
        navigationController.navigationBar.prefersLargeTitles = homeTabBar.navnPreferLargeTitles
        navigationController.tabBarItem = UITabBarItem(title: homeTabBar.title, image: homeTabBar.image, selectedImage: homeTabBar.image)
        switch homeTabBar {
        case .movies:
            let vc = UITabBarController()
            let barItems: [FilterTabBar] = [.popular(.movie), .nowPlaying(.movie), .topRated(.movie)].sorted(by: { $0.order < $1.order })
            let filterNavControllers = barItems.map { prepareFilterNavigationController(with: $0) }
            vc.setViewControllers(filterNavControllers, animated: true)
            navigationController.pushViewController(vc, animated: true)
        case .tvShow:
            let vc = UITabBarController()
            let barItems: [FilterTabBar] = [.popular(.tvShow), .nowPlaying(.tvShow), .topRated(.tvShow)].sorted(by: { $0.order < $1.order })
            let filterNavControllers = barItems.map { prepareFilterNavigationController(with: $0) }
            vc.setViewControllers(filterNavControllers, animated: true)
            navigationController.pushViewController(vc, animated: true)
        case .profile:
            let vc = ProfileViewController.instatiate(from: .profile)
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
            profileCoordinator.parentCoordinator = self
            add(childCoordinator: profileCoordinator)
            vc.coordinator = profileCoordinator
            vc.viewModel = ProfileViewModel()
            navigationController.pushViewController(vc, animated: true)
        case .search:
            let vc = SearchViewController.instatiate(from: .search)
            let searchCoordinator = SearchCoordinator(navigationController: navigationController)
            searchCoordinator.parentCoordinator = self
            add(childCoordinator: searchCoordinator)
            vc.coordinator = searchCoordinator
            vc.viewModel = SearchViewModel()
            navigationController.pushViewController(vc, animated: true)
        }
        return navigationController
    }
    
    private func prepareFilterNavigationController(with filterTabBar: FilterTabBar) -> UINavigationController {
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: filterTabBar.title, image: filterTabBar.image, selectedImage: filterTabBar.image)
        let vc = ListingTableViewController.instatiate(from: .listing)
        let coordinator = ListingCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        vc.coordinator = coordinator
        vc.viewModel = ListingViewModel(typeMedia: filterTabBar.typeMedia, filter: filterTabBar.typeFilter)
        navigationController.pushViewController(vc, animated: true)
        
        return navigationController
    }
}
