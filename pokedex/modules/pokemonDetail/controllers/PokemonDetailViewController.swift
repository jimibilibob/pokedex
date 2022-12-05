//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by user on 28/11/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: PokemonRaw?
    var evolutionChain: [PokemonRaw]?
    @IBOutlet var scrollView: UIScrollView!

    lazy var viewModel = {
        PokemonDetailViewModel()
    }()

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
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: bodyView.bounds.width * 2, height: bodyView.bounds.height)
        scrollView.showsHorizontalScrollIndicator = false
        loadSections()
    }

    func loadSections() {
        // swiftlint:disable unused_enumerated
        for (index, _) in [1, 2].enumerated() {
            guard let pokemon = pokemon else { return }
            if index == 0,
               let statisticSection = Bundle.main.loadNibNamed("PokemonStatisticsView", owner: self)?.first as? PokemonStatisticsSlide {
                scrollView.addSubview(statisticSection)
                statisticSection.frame.size.width = bodyView.bounds.width
                statisticSection.frame.origin.x = CGFloat(index) * bodyView.bounds.size.width
                statisticSection.pokemon = pokemon
                statisticSection.setupViews()
                continue
            }
            guard let evolutionSection = Bundle.main.loadNibNamed("PokemonEvolutionView", owner: self)?.first as? PokemonEvolutionSlide else { continue }
             scrollView.addSubview(evolutionSection)
            evolutionSection.pokemon = pokemon
            evolutionSection.evolutionChain = self.evolutionChain
            evolutionSection.frame.size.width = bodyView.bounds.width
            evolutionSection.frame.origin.x = CGFloat(index) * bodyView.bounds.size.width
            evolutionSection.setupViews()
        }
    }

    func setupViews() {
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
        pokemonName.text = pokemon.name.capitalized
        pokemonIndex.text = PokemonHelper.shared.getPokemonIndexString(id: pokemon.id)
        pokemonTypes.text = pokemon.getTypesString()

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        view.backgroundColor = color
        bodyView.backgroundColor = color
        ImageHelper.shared.downloadAndCacheImage(imageView: pokemonImage, urlString: pokemon.urlImage)
    }

}
