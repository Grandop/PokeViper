//
//  PVPokemonListPresenter.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVPokemonListPresenter: PVPokemonListPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: PVPokemonListCoordinatorInterface
    let interactor: PVPokemonListInteractorInput
    weak var viewModel: PVPokemonListViewModel?
    private var pokemonList: [PokemonOutput] = []
    private var typeList: [TypesOutput]
    
    // MARK: Initalizer
    
    init(coordinator: PVPokemonListCoordinatorInterface, interactor: PVPokemonListInteractorInput, typeList: [TypesOutput]) {
        self.coordinator = coordinator
        self.interactor = interactor
        self.typeList = typeList
        self.interactor.output = self
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: PVPokemonListViewModel) {
        self.viewModel = viewModel
        
        viewModel.setBackgroundImage(.imgBackground)
        viewModel.setTypeList(typeList: typeList)
        
        fetchPokemonList()
    }
    
    private func fetchPokemonList() {
        interactor.fetchPokemonList()
    }
    
    func filterByType(type: TypesOutput) {
        guard let typeEnum = Types(rawValue: type.name) else { return }
        let filteredTypePokemons = pokemonList.filter({ ($0.type.contains(typeEnum)) })
        viewModel?.setPokemonList(pokemonList: filteredTypePokemons)
    }
}

// MARK: - PVPokemonListInteractorOutput

extension PVPokemonListPresenter: PVPokemonListInteractorOutput {
    func fetchPokemonListSucceeded(output: [PokemonOutput]) {
        pokemonList = output
        viewModel?.setPokemonList(pokemonList: output)
    }
    
    func fetchPokemonListFailed() {
        print("putz")
    }
}
