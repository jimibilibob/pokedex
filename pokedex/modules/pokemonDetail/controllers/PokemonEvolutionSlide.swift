//
//  PokemonEvolutionSlide.swift
//  pokedex
//
//  Created by user on 2/12/22.
//

import Foundation
import UIKit

class PokemonEvolutionSlide: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    var pokemon: PokemonRaw?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupViews() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true

        guard let pokemon = pokemon else { return }
        let uiNib = UINib(nibName: EvolutionTableViewCell.identifier, bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: EvolutionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        titleLabel.textColor = color
    }

}

extension PokemonEvolutionSlide: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EvolutionTableViewCell.identifier, for: indexPath) as? EvolutionTableViewCell
        ?? EvolutionTableViewCell(style: .value1, reuseIdentifier: EvolutionTableViewCell.identifier)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}
