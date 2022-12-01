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

    var searchText = ""

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

    func searchPokemonsByName() {
        if !self.searchText.isEmpty {
            pokemons = pokemons.filter({
                $0.name.contains(searchText.lowercased())
            })
        }
    }

}
