//
//  Coordinator.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    var parentCoordinator: Coordinator? {get set}
    
    func start()
    
    func add(childCoordinator coordinator: Coordinator)
    
    func remove(childCoordinator coordinator: Coordinator)
    
    func didFinish(child coordinator: Coordinator?)
}

extension Coordinator {
    func add(childCoordinator coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func didFinish(child coordinator: Coordinator?) {
        guard let coordinator = coordinator else {return}
        remove(childCoordinator: coordinator)
    }
}
