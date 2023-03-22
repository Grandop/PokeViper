//
//  PVInitialPresenter.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVInitialPresenter: PVInitialPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: PVInitialCoordinatorInterface
    weak var viewModel: PVInitialViewModel?
    
    // MARK: Initalizer
    
    init(coordinator: PVInitialCoordinatorInterface) {
        self.coordinator = coordinator
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: PVInitialViewModel) {
        self.viewModel = viewModel
        
        viewModel.setBackgroundImage(.imgBackground)
        viewModel.setFinderImage(.imgFinderLogo)
        viewModel.setPokemonLogoImage(.imgPokemonLogo)
        viewModel.setPikachuImage(.imgPikachu)
        viewModel.setButtonTitle("Let's go")
    }
    
    func goToMeet() {
        coordinator.goToMeet()
    }
}
