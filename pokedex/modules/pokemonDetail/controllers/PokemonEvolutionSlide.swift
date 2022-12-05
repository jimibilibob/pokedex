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
    var evolutionChain: [PokemonRaw]?

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
        guard let evolutionChain = evolutionChain,
              evolutionChain.count > 1 else { return 0 }
        return evolutionChain.count - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let evolutionChain = evolutionChain else { return EvolutionTableViewCell(style: .value1, reuseIdentifier: EvolutionTableViewCell.identifier) }
        let pokemonFrom = evolutionChain[indexPath.row]
        let pokemonTo = evolutionChain[indexPath.row + 1]

        let cell = tableView.dequeueReusableCell(withIdentifier: EvolutionTableViewCell.identifier, for: indexPath) as? EvolutionTableViewCell
        ?? EvolutionTableViewCell(style: .value1, reuseIdentifier: EvolutionTableViewCell.identifier)

        cell.pokemonFrom = pokemonFrom
        cell.pokemonTo = pokemonTo

        cell.loadData()

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}
