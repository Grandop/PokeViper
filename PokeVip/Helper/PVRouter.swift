//
//  PVRouter.swift
//  PokeVip
//
//  Created by Matheus Bondan on 09/02/23.
//

import UIKit

protocol AppRouterProtocol: AnyObject {
    func showInitial(navigator: UINavigationController?)
    func showMeet()
    func showChooseType(_ name: String)
    func showPokemonList(types: [TypesOutput])
}

final class AppRouter: AppRouterProtocol {
    
    private init() { }
    
    public static var shared = AppRouter()
    public var navigator: UINavigationController?
    
    func showInitial(navigator: UINavigationController?) {
        let coordinator = PVInitialCoordinator()
        coordinator.navigator = navigator
        coordinator.start()
    }
    
    func showMeet() {
        let coordinator = PVMeetCoordinator()
        coordinator.navigator = navigator
        coordinator.start()
    }
    
    func showChooseType(_ name: String) {
        let coordinator = PVChooseTypeCoordinator()
        coordinator.navigator = navigator
        coordinator.start(name)
    }
    
    func showPokemonList(types: [TypesOutput]) {
        let coordinator = PVPokemonListCoordinator()
        coordinator.navigator = navigator
        coordinator.start(types: types)
    }
}


