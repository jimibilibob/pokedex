//
//  PokemonStatisticsSlide.swift
//  pokedex
//
//  Created by user on 2/12/22.
//

import Foundation
import UIKit
import Charts

class PokemonStatisticsSlide: UIView {

    @IBOutlet var radarChart: RadarChartView!
    @IBOutlet var titleLabel: UILabel!

    var pokemon: PokemonRaw?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
    }

    func setupViews() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true

        guard let pokemon = pokemon else { return }

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        titleLabel.textColor = color
    }

    // 1
    let greenDataSet = RadarChartDataSet(
        entries: [
            RadarChartDataEntry(value: 210),
            RadarChartDataEntry(value: 60.0),
            RadarChartDataEntry(value: 150.0),
            RadarChartDataEntry(value: 150.0),
            RadarChartDataEntry(value: 160.0),
            RadarChartDataEntry(value: 150.0),
            RadarChartDataEntry(value: 110.0),
            RadarChartDataEntry(value: 190.0),
            RadarChartDataEntry(value: 200.0)
        ]
    )
    let redDataSet = RadarChartDataSet(
        entries: [
            RadarChartDataEntry(value: 120.0),
            RadarChartDataEntry(value: 160.0),
            RadarChartDataEntry(value: 110.0),
            RadarChartDataEntry(value: 110.0),
            RadarChartDataEntry(value: 210.0),
            RadarChartDataEntry(value: 120.0),
            RadarChartDataEntry(value: 210.0),
            RadarChartDataEntry(value: 100.0),
            RadarChartDataEntry(value: 210.0)
        ]
    )

    func setupChart() {
        // 2
        let data = RadarChartData(dataSets: [greenDataSet, redDataSet])

        // 3
        radarChart.data = data

//        // 1
//        redDataSet.lineWidth = 2
//
//        // 2
//        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
//        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 0.6)
//        redDataSet.colors = [redColor]
//        redDataSet.fillColor = redFillColor
//        redDataSet.drawFilledEnabled = true
//
//        // 3
//        redDataSet.valueFormatter = DataSetValueFormatter()
    }
}
