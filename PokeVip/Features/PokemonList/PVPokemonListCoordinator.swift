//
//  PVPokemonListCoordinator.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVPokemonListCoordinator: PVPokemonListCoordinatorInterface {
    
    // MARK: Properties
    
    var navigator: UINavigationController?
    
    // MARK: Methods
    
    func start(types: [TypesOutput]) {
        let interactor = PVPokemonListInteractor()
        let presenter = PVPokemonListPresenter(coordinator: self, interactor: interactor, typeList: types)
        let viewController = PVPokemonListViewController(presenter: presenter)
        
        navigator?.pushViewController(viewController, animated: true)
    }
}
