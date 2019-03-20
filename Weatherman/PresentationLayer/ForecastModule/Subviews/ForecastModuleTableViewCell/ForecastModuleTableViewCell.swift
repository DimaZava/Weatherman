//
//  ForecastModuleTableViewCell.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Kingfisher
import UIKit

class ForecastModuleTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak private var weatherIconImageView: UIImageView!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var weatherDescriptionLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!

    var isCustomSelected = false

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected, !isCustomSelected {
            contentView.borderColor = .blue
            contentView.borderWidth = 2.0
            isCustomSelected = true
        } else {
            contentView.borderColor = .clear
            isCustomSelected = false
        }
    }

    func configure(for dayWeather: DayWeather) {
        weatherIconImageView.kf.setImage(with: dayWeather.icon?.url)
        timeLabel.text = dayWeather.time.timeString(ofStyle: .short)
        weatherDescriptionLabel.text = dayWeather.weatherDescription
        temperatureLabel.text = dayWeather.temperature.trim(decimalPlaces: 0) + "º"
    }
}
