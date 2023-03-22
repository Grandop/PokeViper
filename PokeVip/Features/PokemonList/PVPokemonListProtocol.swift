//
//  PVPokemonListProtocol.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

protocol PVPokemonListViewModel: AnyObject {
    func setPokemonList(pokemonList: [PokemonOutput])
    func setTypeList(typeList: [TypesOutput])
    func setBackgroundImage(_ image: PVImageType)
}

protocol PVPokemonListPresenterInterface: AnyObject {
    var coordinator: PVPokemonListCoordinatorInterface { get }
    var interactor: PVPokemonListInteractorInput { get }
    var viewModel: PVPokemonListViewModel? { get }
    func setViewModel(_ viewModel: PVPokemonListViewModel)
    func filterByType(type: TypesOutput)
}

protocol PVPokemonListInteractorOutput: AnyObject {
    func fetchPokemonListSucceeded(output: [PokemonOutput])
    func fetchPokemonListFailed()
}

protocol PVPokemonListInteractorInput: AnyObject {
    var api: ApiProtocol? { get set }
    var output: PVPokemonListInteractorOutput? { get set }
    func fetchPokemonList()
}

protocol PVPokemonListCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start(types: [TypesOutput])
}
