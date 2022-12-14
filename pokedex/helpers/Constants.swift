//
//  Constants.swift
//  pokedex
//
//  Created by user on 25/11/22.
//

import Foundation

class Constants {
    static let pokeApiEndpoint = "https://beta.pokeapi.co/graphql/v1beta"
    static let pokeApiEndpoint2 = "https://graphql-pokeapi.vercel.app/api/graphql"
    static let pokemonImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    static let pokemonTypes = [
        TypeElement(type: Generation(id: 1, name: "normal")),
        TypeElement(type: Generation(id: 2, name: "fighting")),
        TypeElement(type: Generation(id: 3, name: "flying")),
        TypeElement(type: Generation(id: 4, name: "poison")),
        TypeElement(type: Generation(id: 5, name: "ground")),
        TypeElement(type: Generation(id: 6, name: "rock")),
        TypeElement(type: Generation(id: 7, name: "bug")),
        TypeElement(type: Generation(id: 8, name: "ghost")),
        TypeElement(type: Generation(id: 9, name: "steel")),
        TypeElement(type: Generation(id: 10, name: "fire")),
        TypeElement(type: Generation(id: 11, name: "water")),
        TypeElement(type: Generation(id: 12, name: "grass")),
        TypeElement(type: Generation(id: 13, name: "electric")),
        TypeElement(type: Generation(id: 14, name: "psychic")),
        TypeElement(type: Generation(id: 15, name: "ice")),
        TypeElement(type: Generation(id: 16, name: "dragon")),
        TypeElement(type: Generation(id: 17, name: "dark")),
        TypeElement(type: Generation(id: 18, name: "fairy"))
    ]
}
