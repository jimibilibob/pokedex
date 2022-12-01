//
//  PokemonTableViewCell.swift
//  pokedex
//
//  Created by user on 25/11/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    static let identifier = "PokemonTableViewCell"

    @IBOutlet var pokemonIndexLabel: UILabel!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var mainBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupViews() {
        selectionStyle = .none
        mainBackgroundView.layer.cornerRadius = 10
        mainBackgroundView.clipsToBounds = true
    }

    func loadData(pokemon: PokemonRaw) {
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIndexLabel.text = PokemonHelper.shared.getPokemonIndexString(id: pokemon.id)
        pokemonTypesLabel.text = pokemon.getTypesString()
        mainBackgroundView.backgroundColor = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        ImageHelper.shared.downloadAndCacheImage(imageView: pokemonImage, urlString: pokemon.urlImage)
    }

}
