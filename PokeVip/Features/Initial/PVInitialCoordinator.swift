//
//  PVInitialCoordinator.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVInitialCoordinator: PVInitialCoordinatorInterface {

    // MARK: Properties
    
    var navigator: UINavigationController?
    
    // MARK: Methods
    
    func start() {
        let presenter = PVInitialPresenter(coordinator: self)
        let viewController = PVInitialViewController(presenter: presenter)
        
        navigator?.setNavigationBarHidden(true, animated: false)
        navigator?.pushViewController(viewController, animated: true)
    }
    
    func goToMeet() {
        AppRouter.shared.showMeet()
    }
}
