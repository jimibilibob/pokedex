//
//  PokeApiResponse.swift
//  pokedex
//
//  Created by user on 24/11/22.
//

import Foundation

// MARK: - PokeApiResponse
struct PokeApiResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    var species: [PokemonRaw]
}

struct PokemonRaw: Codable {
    let id: Int
    let name: String
    var urlImage: String = ""
    let generation: Generation
    var pokemonDetails: [PokemonDetail]
    let genderRate, hatchCounter: Int
    let eggGroups: [EggGroupElement]
    let pokedexNumbers: [PokedexNumber]
    let evolvesFromSpeciesID: Int?
    let evolutionChainID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, generation
        case pokemonDetails = "pokemon_details"
        case genderRate = "gender_rate"
        case hatchCounter = "hatch_counter"
        case eggGroups = "egg_groups"
        case pokedexNumbers = "pokedex_numbers"
        case evolvesFromSpeciesID = "evolves_from_species_id"
        case evolutionChainID = "evolution_chain_id"
    }

    func getTypesString() -> String {
        return pokemonDetails.map({ $0.types.map({ $0.type.name.capitalized }).joined(separator: " ") }).first ?? ""
    }
}

// MARK: - Generation
struct Generation: Codable, Equatable {
    let id: Int
    let name: String
    public static func == (lhs: Generation, rhs: Generation) -> Bool {
        return
            lhs.id == rhs.id && lhs.name == rhs.name
    }
}

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let name: String
    let height, weight: Int
    let types: [TypeElement]
    var weaknesses: [Weakness]? = []
    let stats: [Stat]
}

// MARK: - Stat
struct Stat: Codable {
    let effort, baseStat: Int
    let statName: StatNameClass

    enum CodingKeys: String, CodingKey {
        case effort
        case baseStat = "base_stat"
        case statName = "stat_name"
    }
}

// MARK: - StatNameClass
struct StatNameClass: Codable {
    let name: String
}

// MARK: - TypeElement
struct TypeElement: Codable, Equatable {
    let type: Generation
    public static func == (lhs: TypeElement, rhs: TypeElement) -> Bool {
            return
                lhs.type == rhs.type
        }
}

// MARK: - Weakness
struct Weakness: Codable {
    let fromType: Generation
    let damageTaken: Double
}

// MARK: - EggGroupElement
struct EggGroupElement: Codable {
    let eggGroup: EggGroupEggGroup

    enum CodingKeys: String, CodingKey {
        case eggGroup = "egg_group"
    }
}

// MARK: - EggGroupEggGroup
struct EggGroupEggGroup: Codable {
    let name: String
}

// MARK: - PokedexNumber
struct PokedexNumber: Codable {
    let pokedexes: Pokedexes
    let pokedexNumber: Int

    enum CodingKeys: String, CodingKey {
        case pokedexes
        case pokedexNumber = "pokedex_number"
    }
}

// MARK: - Pokedexes
struct Pokedexes: Codable {
    let pokedexesDescriptions: [PokedexesDescription]

    enum CodingKeys: String, CodingKey {
        case pokedexesDescriptions = "pokedexes_descriptions"
    }
}

// MARK: - PokedexesDescription
struct PokedexesDescription: Codable {
    let languageID: Int
    let pokedexesDescriptionDescription: String

    enum CodingKeys: String, CodingKey {
        case languageID = "language_id"
        case pokedexesDescriptionDescription = "description"
    }
}
