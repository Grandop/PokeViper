//
//  PVChooseTypeCoordinator.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVChooseTypeCoordinator: PVChooseTypeCoordinatorInterface {
    
    // MARK: Properties
    
    var navigator: UINavigationController?
    
    // MARK: Methods
    
    func start(_ name: String) {
        let interactor = PVChooseTypeInteractor()
        let presenter = PVChooseTypePresenter(coordinator: self, interactor: interactor, name: name)
        let viewController = PVChooseTypeViewController(presenter: presenter)
        
        navigator?.pushViewController(viewController, animated: true)
    }
    
    func goToPokeList(types: [TypesOutput]) {
        AppRouter.shared.showPokemonList(types: types)
    }
}
