//
//  PokemonHelper.swift
//  pokedex
//
//  Created by user on 28/11/22.
//

import Foundation
import UIKit

class PokemonHelper {
    static let shared = PokemonHelper()

    func getPokemonIndexString(id: Int) -> String {
        switch id {
        case 0...9:
            return "#00\(id)"
        case 10...99:
            return "#0\(id)"
        case 100...999:
            return "#\(id)"
        default:
            return ""
        }
    }

    func getImage(pokemon: PokemonRaw) -> UIImage? {
        guard let url = URL(string: pokemon.urlImage),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return nil }
        return image
    }
}
