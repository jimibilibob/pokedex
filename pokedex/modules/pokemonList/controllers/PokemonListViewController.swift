//
//  ViewController.swift
//  pokedex
//
//  Created by user on 23/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchBarView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!

    lazy var viewModel = {
        PokemonListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initViewModel()
    }

    func setupViews() {
        searchBarView.layer.cornerRadius = 10
        searchBarView.clipsToBounds = true

        let nib = UINib(nibName: PokemonTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func initViewModel() {
        viewModel.getPokemons()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.showErrorAlert = {
            let sheet = UIAlertController(title: "Something went wrong", message: "Can't show pokemons right now, please try again later",
            preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.navigationController?.present(sheet, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = viewModel.pokemons[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell
        ?? PokemonTableViewCell(style: .default, reuseIdentifier: PokemonTableViewCell.identifier)

        cell.loadData(pokemon: pokemon)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemons[indexPath.row]
        let vc = PokemonDetailViewController()
        vc.pokemon = pokemon
        show(vc, sender: nil)
    }
}
