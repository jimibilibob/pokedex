//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by user on 25/11/22.
//

import Foundation
import UIKit

class PokemonListViewModel {
    var reloadData: (() -> Void)?
    var showErrorAlert: (() -> Void)?
    var loading: (() -> Void)?
    var loaded: (() -> Void)?

    var filteredPokemons = [PokemonRaw]()
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadData?()
            loaded?()
        }
    }

    func getPokemons() {
        loading?()
        PokedexManager.shared.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.filteredPokemons = pokemons
            case .failure:
                self.showErrorAlert?()
                self.loaded?()
            }
        }
    }

    func searchPokemonsByNameOrIndex(query: String) {
        loading?()
        if query.isEmpty {
            filteredPokemons = pokemons
            reloadData?()
            loaded?()
            return
        }
        let queryLowerCased = query.lowercased()
        filteredPokemons = pokemons.filter({ $0.name.lowercased().contains(queryLowerCased) ||
            String($0.id).contains(queryLowerCased)
        })
        reloadData?()
        loaded?()
    }

    func getEvolutionChain() -> [String: [PokemonRaw]] {
        var pokemonGroupByEvolutionChain: [String: [PokemonRaw]] = [:]
        pokemons.forEach({ pokemon in
            let key = "\(pokemon.evolutionChainID ?? 0)"
            if pokemonGroupByEvolutionChain[key] == nil {
                pokemonGroupByEvolutionChain[key] = [pokemon]
            } else {
                pokemonGroupByEvolutionChain[key]!.append(pokemon)
            }
        })
        return pokemonGroupByEvolutionChain
    }
}
