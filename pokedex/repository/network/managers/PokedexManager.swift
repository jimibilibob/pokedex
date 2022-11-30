//
//  PokedexManager.swift
//  pokedex
//
//  Created by user on 25/11/22.
//

import Foundation
import Apollo

class PokedexManager {

    static let shared = PokedexManager()

    func getPokemons(completion: @escaping (Result<[PokemonRaw], Error>) -> Void) {
        NetworkManager.shared.apollo.fetch(query: HomePageQuery()) { data in
            switch data {
            case .success(let graphResult):
                GraphQLConverter.shared.convertFromDataToPokemonStruct(data: graphResult.data!) { data in
                    switch data {
                    case.success(let species):
                        DispatchQueue.main.async {
                            completion(.success(species))
                        }
                    case.failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

    }

    func getEvolutionChainById(id: String, completion: @escaping (Result<EvolutionQuery.Data?, Error>) -> Void) {
        NetworkManager.shared.apollo2.fetch(query: EvolutionQuery()) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
