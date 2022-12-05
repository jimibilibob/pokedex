//
//  ViewController.swift
//  pokedex
//
//  Created by user on 23/11/22.
//

import UIKit
import SVProgressHUD

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

        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    }

    func initViewModel() {
        viewModel.loading = SVProgressHUD.show
        viewModel.loaded = SVProgressHUD.dismiss
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

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text else { return }
        viewModel.searchPokemonsByNameOrIndex(query: query)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredPokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = viewModel.filteredPokemons[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell
        ?? PokemonTableViewCell(style: .default, reuseIdentifier: PokemonTableViewCell.identifier)

        cell.loadData(pokemon: pokemon)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.filteredPokemons[indexPath.row]
        let vc = PokemonDetailViewController()
        vc.pokemon = pokemon
        vc.evolutionChain = viewModel.getEvolutionChain()[String(pokemon.evolutionChainID ?? 0)]
        show(vc, sender: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let query = textField.text else { return }
        viewModel.searchPokemonsByNameOrIndex(query: query)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = textField.text else { return true }
        viewModel.searchPokemonsByNameOrIndex(query: query)
        return true
    }

}
