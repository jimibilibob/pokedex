//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by user on 28/11/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: PokemonRaw?

    @IBOutlet var evolutionSectionTitle: UILabel!
    @IBOutlet var evolutionTableView: UITableView!
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
        loadEvolutionChain()
    }

    func setupViews() {
        bodyView.layer.cornerRadius = 25
        bodyView.clipsToBounds = true

        let nib = UINib(nibName: EvolutionTableViewCell.identifier, bundle: nil)
        evolutionTableView.register(nib, forCellReuseIdentifier: EvolutionTableViewCell.identifier)
        evolutionTableView.delegate = self
        evolutionTableView.dataSource = self

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

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        view.backgroundColor = color
        evolutionSectionTitle.textColor = color
        guard let image = PokemonHelper.shared.getImage(pokemon: pokemon) else { return }
        pokemonImage.image = image
    }

    func loadEvolutionChain() {
        guard let pokemon = pokemon else { return }
        PokedexManager.shared.getEvolutionChainById(id: String(pokemon.id)) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
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
