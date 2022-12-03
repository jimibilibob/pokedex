//
//  PokemonStatisticsSlide.swift
//  pokedex
//
//  Created by user on 2/12/22.
//

import Foundation
import UIKit

class PokemonStatisticsSlide: UIView {

    @IBOutlet var titleLabel: UILabel!

    var pokemon: PokemonRaw?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupViews() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true

        guard let pokemon = pokemon else { return }

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        titleLabel.textColor = color
    }

}
