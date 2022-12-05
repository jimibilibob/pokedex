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
    var dataSet = RadarChartDataSet(entries: [])
    var labels: [String] = []
    var borderColor = UIColor.red
    var fillColor = UIColor.red.withAlphaComponent(0.6)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupViews() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true

        guard let pokemon = pokemon else { return }

        let color = UIColor(hexString: PokemonColors.pokemonTypeColorMap[pokemon.pokemonDetails[0].types[0].type.name] ?? "normal")
        titleLabel.textColor = color
        borderColor = color
        fillColor = color.withAlphaComponent(0.6)
        var entries: [RadarChartDataEntry] = []
        pokemon.pokemonDetails[0].stats.forEach({ statistic in
            entries.append(RadarChartDataEntry(value: Double(statistic.baseStat)))
            self.labels.append(statistic.statName.name)
        })
        dataSet = RadarChartDataSet(
            entries: entries
        )
        setupChart()
    }

    func setupChart() {
        dataSet.lineWidth = 2
        dataSet.colors = [borderColor]
        dataSet.fillColor = fillColor
        dataSet.drawFilledEnabled = true

        dataSet.valueFormatter = DataSetValueFormatter()

        let data = RadarChartData(dataSet: dataSet)

        radarChart.data = data

        radarChart.webLineWidth = 1.5
        radarChart.innerWebLineWidth = 1.5
        radarChart.webColor = .lightGray
        radarChart.innerWebColor = .lightGray
        radarChart.data?.setValueFont(.systemFont(ofSize: 9, weight: .bold))

        let xAxis = radarChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .bold)
        xAxis.labelTextColor = borderColor
        xAxis.xOffset = 10
        xAxis.yOffset = 10
        let xValueFormatter = XAxisFormatter()
        xValueFormatter.labels = self.labels
        xAxis.valueFormatter = xValueFormatter

        let yAxis = radarChart.yAxis
        yAxis.labelFont = .systemFont(ofSize: 0, weight: .light)
        yAxis.labelCount = 1
        yAxis.drawTopYLabelEntryEnabled = true
        yAxis.axisMinimum = 0
        yAxis.valueFormatter = YAxisFormatter()

        radarChart.rotationEnabled = false
        radarChart.legend.enabled = false
    }
}

class DataSetValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        "\(value)"
    }

}

class XAxisFormatter: IndexAxisValueFormatter {
    var labels: [String] = []

    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        labels[Int(value) % labels.count]
    }

}

class YAxisFormatter: IndexAxisValueFormatter {
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        ""
    }
}
