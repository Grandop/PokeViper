//
//  PVChooseTypePresenter.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVChooseTypePresenter: PVChooseTypePresenterInterface {
    
    // MARK: Properties
    
    let coordinator: PVChooseTypeCoordinatorInterface
    let interactor: PVChooseTypeInteractorInput
    weak var viewModel: PVChooseTypeViewModel?
    private let name: String
    private var listTypes: [TypesOutput] = []
    private var typeSelected: TypesOutput?
    
    // MARK: Initalizer
    
    init(coordinator: PVChooseTypeCoordinatorInterface, interactor: PVChooseTypeInteractorInput, name: String) {
        self.coordinator = coordinator
        self.interactor = interactor
        self.name = name
        self.interactor.output = self
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: PVChooseTypeViewModel) {
        self.viewModel = viewModel
        
        viewModel.setBackgroundImage(.imgBackground)
        viewModel.setButtonTitle("Confirmar")
        viewModel.setTitle("Olá, \(name)")
        viewModel.setSubtitle("... agora me conte qual é seu Tipo Pokémon favorito:")
        
        fetchTypes()
    }
    
    func goToPokeList() {
        coordinator.goToPokeList(types: listTypes)
    }
    
    private func fetchTypes(){
        interactor.fetchTypes()
    }
    
    func dropDownSelected(index: Int) {
        typeSelected = listTypes[index]
        viewModel?.setDropdownSelected(value: listTypes[index].name)
    }
}

// MARK: - PVChooseTypeInteractorOutput

extension PVChooseTypePresenter: PVChooseTypeInteractorOutput {
    func fetchTypesSucceeded(output: ListTypesOutput) {
        listTypes = output.results
        let listItems:[PVDropDownListItemType] = output.results.map { type in
                .type(PVDropDownListTypeDataSource(imageType: type.thumbnailImage, title: type.name))
        }
        let dataSource = PVDropdownListDataSource(title: "Selecione o tipo", items: listItems)
        viewModel?.setupDropdown(dataSource: dataSource)
    }
    
    func fetchTypesFailed() {
        print("putz")
    }
}
