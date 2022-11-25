//
//  ViewController.swift
//  pokedex
//
//  Created by user on 23/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        searchBarView.layer.cornerRadius = 15
        searchBarView.clipsToBounds = true
    }
}
