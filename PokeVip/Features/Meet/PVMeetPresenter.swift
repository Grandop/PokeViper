//
//  PVMeetPresenter.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVMeetPresenter: PVMeetPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: PVMeetCoordinatorInterface
    weak var viewModel: PVMeetViewModel?
    
    // MARK: Initalizer
    
    init(coordinator: PVMeetCoordinatorInterface) {
        self.coordinator = coordinator
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: PVMeetViewModel) {
        self.viewModel = viewModel
        
        viewModel.setBackgroundImage(.imgBackground)
        viewModel.setButtonTitle("Muito prazer!")
        viewModel.setTitle("Para começar, que tal nos conhecermos?")
        viewModel.setSubtitle("Primeiramente precisamos saber como quer ser chamado...")
    }
    
    func goToChooseType(_ name: String) {
        coordinator.goToChooseType(name)
    }
}
