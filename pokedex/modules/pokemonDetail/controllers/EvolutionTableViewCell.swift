//
//  EvolutionTableViewCell.swift
//  pokedex
//
//  Created by user on 29/11/22.
//

import UIKit

class EvolutionTableViewCell: UITableViewCell {

    static let identifier = "EvolutionTableViewCell"
    var pokemonFrom: PokemonRaw?
    var pokemonTo: PokemonRaw?

    @IBOutlet var levelTriggerLabel: UILabel!

    @IBOutlet var evolvesFromName: UILabel!
    @IBOutlet var evolvesFromIndex: UILabel!
    @IBOutlet var evolvesFromImage: UIImageView!

    @IBOutlet var evolvesToName: UILabel!
    @IBOutlet var evolvesToImage: UIImageView!
    @IBOutlet var evolvesToIndex: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func loadData() {
        guard let pokemonFrom = pokemonFrom,
            let pokemonTo = pokemonTo else { return }
        evolvesFromName.text = pokemonFrom.name
        evolvesFromIndex.text = PokemonHelper.shared.getPokemonIndexString(id: pokemonFrom.id)
        ImageHelper.shared.downloadAndCacheImage(imageView: evolvesFromImage, urlString: pokemonFrom.urlImage)

        evolvesToName.text = pokemonTo.name
        evolvesToIndex.text = PokemonHelper.shared.getPokemonIndexString(id: pokemonTo.id)
        ImageHelper.shared.downloadAndCacheImage(imageView: evolvesToImage, urlString: pokemonTo.urlImage)
    }
}
