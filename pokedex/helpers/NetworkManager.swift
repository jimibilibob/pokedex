//
//  NetworkManager.swift
//  pokedex
//
//  Created by user on 25/11/22.
//

import Foundation
import Apollo

class NetworkManager {

    static let shared = NetworkManager()

    lazy var apollo = ApolloClient(url: URL(string: Constants.pokeApiEndpoint)!)

}
