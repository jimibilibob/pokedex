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

    var filteredPokemons = [PokemonRaw]()
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadData?()
        }
    }
    var searchText = ""

    func getPokemons() {
        PokedexManager.shared.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.filteredPokemons = pokemons
            case .failure:
                self.showErrorAlert?()
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
