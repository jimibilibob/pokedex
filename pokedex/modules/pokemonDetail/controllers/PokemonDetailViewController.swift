//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by user on 28/11/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: PokemonRaw?

    @IBOutlet var sectionContainerStaick: UIStackView!
    @IBOutlet var pokeballSelectorImage: UIImageView!
    @IBOutlet var statsSectionLabel: UILabel!
    @IBOutlet var evolutionSectionLabel: UILabel!
    @IBOutlet var bodyView: UIView!
    @IBOutlet var pokemonTypes: UILabel!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonIndex: UILabel!
    @IBOutlet var pokemonImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }

    func setupViews() {
        bodyView.layer.cornerRadius = 25
        bodyView.clipsToBounds = true

        let tapEvolution = UITapGestureRecognizer(target: self, action: #selector(tapOnEvolution))
        evolutionSectionLabel.addGestureRecognizer(tapEvolution)

        let tapStats = UITapGestureRecognizer(target: self, action: #selector(tapOnStats))
        statsSectionLabel.addGestureRecognizer(tapStats)
    }

    @objc
    func tapOnEvolution() {
        let center = evolutionSectionLabel.center
        let frame = evolutionSectionLabel.superview?.convert(statsSectionLabel.frame, to: view)
        UIImageView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.pokeballSelectorImage.center = center
            self.pokeballSelectorImage.center.y = (frame?.origin.y ?? 0) + 35
        })
    }

    @objc
    func tapOnStats() {
        let center = statsSectionLabel.center
        let frame = statsSectionLabel.superview?.convert(statsSectionLabel.frame, to: view)
        UIImageView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.pokeballSelectorImage.center = center
            self.pokeballSelectorImage.center.y = (frame?.origin.y ?? 0) + 35
        })
    }

    func setupData() {
        guard let pokemon = pokemon else { return }
        pokemonName.text = pokemon.name
        pokemonIndex.text = PokemonHelper.shared.getPokemonIndexString(id: pokemon.id)
        pokemonTypes.text = pokemon.getTypesString()
        guard let image = PokemonHelper.shared.getImage(pokemon: pokemon) else { return }
        pokemonImage.image = image
    }

}
