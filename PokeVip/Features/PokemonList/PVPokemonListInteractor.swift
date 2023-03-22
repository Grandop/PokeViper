//
//  PVPokemonListInteractor.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVPokemonListInteractor: PVPokemonListInteractorInput {
    
    var api: ApiProtocol?
    var output: PVPokemonListInteractorOutput?
    init(api: ApiProtocol = ApiWorker.shared) {
        self.api = api
    }
    
    func fetchPokemonList() {
        api?.requestObject(
            endpoint: Endpoint.pokeList.url,
            method: .get,
            headers: nil,
            type: [PokemonOutput].self,
            encoder: .json
        )
        { [weak self] result in
            switch result {
            case .success(let output):
                self?.output?.fetchPokemonListSucceeded(output: output)
            case .failure:
                self?.output?.fetchPokemonListFailed()
            }
        }
    }
}

struct PokemonOutput: Decodable {
    let abilities: [String]
    let detailPageURL: String
    let weight: Double
    let weakness: [String]
    let number: String
    let height: Double
    let collectibles_slug: String
    let featured: String
    let slug: String
    let name: String
    let thumbnailAltText: String
    let thumbnailImage: String
    let id: Int
    let type: [Types]
}

public enum Types: String, Decodable {
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case rock = "rock"
    case bug = "bug"
    case ghost = "ghost"
    case steel = "steel"
    case fire = "fire"
    case water = "water"
    case grass = "grass"
    case electric = "electric"
    case psychic = "psychic"
    case ice = "ice"
    case dragon = "dragon"
    case dark = "dark"
    case fairy = "fairy"
}
