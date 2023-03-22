//
//  PVMeetCoordinator.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVMeetCoordinator: PVMeetCoordinatorInterface {
    
    // MARK: Properties
    
    var navigator: UINavigationController?
    
    // MARK: Methods
    
    func start() {
        let presenter = PVMeetPresenter(coordinator: self)
        let viewController = PVMeetViewController(presenter: presenter)
        
        navigator?.setNavigationBarHidden(false, animated: false)
        navigator?.pushViewController(viewController, animated: true)
    }
    
    func goToChooseType(_ name: String) {
        AppRouter.shared.showChooseType(name)
    }
}
