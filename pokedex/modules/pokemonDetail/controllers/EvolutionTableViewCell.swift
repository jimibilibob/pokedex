//
//  EvolutionTableViewCell.swift
//  pokedex
//
//  Created by user on 29/11/22.
//

import UIKit

class EvolutionTableViewCell: UITableViewCell {

    static let identifier = "EvolutionTableViewCell"
    var pokemon: PokemonRaw?

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
        guard let pokemon = pokemon else { return }
    }
}
