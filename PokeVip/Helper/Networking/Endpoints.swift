//
//  Endpoints.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

enum Endpoint {
    
    private var types: String { "/types.json"}
    private var pokeList: String { "/pokemons.json"}

    case types
    case pokeList

    var url: String {
        switch self {
        case .types:
            return "\(types)"
        case .pokeList:
            return "\(pokeList)"
        }
    }
}
