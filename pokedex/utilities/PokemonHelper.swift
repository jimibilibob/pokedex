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

}
