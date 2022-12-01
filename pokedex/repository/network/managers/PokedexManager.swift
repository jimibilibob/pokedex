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

    func getEvolutionChainById(id: String, completion: @escaping (Result<PokemonEvolutionChainResponse?, Error>) -> Void) {
        NetworkManager.shared.apollo2.fetch(query: EvolutionQuery(id: id)) { result in
            switch result {
            case .success(let response):
                guard let jsonDataRaw = try? JSONSerialization.data(withJSONObject: response.data!.resultMap, options: JSONSerialization.WritingOptions.prettyPrinted),
                      let jsonString = NSString(data: jsonDataRaw, encoding: String.Encoding.utf8.rawValue) as? String else { return }
                let data = Data((jsonString.utf8))
                let decoder = JSONDecoder()
                let jsonData = try? decoder.decode(PokemonEvolutionChainResponse.self, from: data)

                completion(.success(jsonData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
