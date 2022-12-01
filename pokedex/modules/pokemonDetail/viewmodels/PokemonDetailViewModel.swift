//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by user on 30/11/22.
//

import Foundation

class PokemonDetailViewModel {
    var reloadData: (() -> Void)?
    var showErrorAlert: (() -> Void)?

    var pokemonEvolutionChain: PokemonEvolutionChainResponse?

    func getEvolutionChain(pokemon: PokemonRaw) {
        PokedexManager.shared.getEvolutionChainById(id: String(pokemon.id)) { result in
            switch result {
            case .success(let data):
                self.pokemonEvolutionChain = data
                self.reloadData?()
            case .failure(let error):
                print(error)
                self.showErrorAlert?()
            }
        }
    }

}
