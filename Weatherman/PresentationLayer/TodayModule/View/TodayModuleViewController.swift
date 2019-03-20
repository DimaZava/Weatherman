//
//  TodayModuleTodayModuleViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import Kingfisher
import UIKit

class TodayModuleViewController: WeathermanViewController {

    // MARK: - Outlets
    @IBOutlet weak private var weatherIconImageView: UIImageView!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var temperatureAndDescriptionLabel: UILabel!

    @IBOutlet weak private var humidityLabel: UILabel!
    @IBOutlet weak private var rainLevelLabel: UILabel!
    @IBOutlet weak private var pressureLabel: UILabel!
    @IBOutlet weak private var windSpeedLabel: UILabel!
    @IBOutlet weak private var windDirectionLabel: UILabel!

    // MARK: - Constants

    // MARK: - Properties
    var output: TodayModuleViewOutput!
    var currentWeather: CurrentWeather?

    // MARK: - Overrides
    override var barTitle: String? {
        return "Today".localized()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.onViewWillAppear()
    }

    deinit {
        unsubscribe()
    }

    // MARK: - Actions
    @IBAction private func shareButtonTouchUpInside(_ button: UIButton) {
        guard let currentWeather = self.currentWeather else { return }
        presentShareController(sourceView: button,
                               text: currentWeather.stringRepresentation,
                               image: weatherIconImageView.image)
    }

    // MARK: - Other
    func configureView(for currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
        weatherIconImageView.kf.setImage(with: currentWeather.icon?.url)
        locationLabel.text = currentWeather.city + ", " + currentWeather.country
        temperatureAndDescriptionLabel.text
            = (currentWeather.temperature?.trim(decimalPlaces: 0) ?? "") + "℃ | " + currentWeather.weatherDescription
        humidityLabel.text = (currentWeather.humidity?.string ?? "N/A") + "%"
        rainLevelLabel.text = (currentWeather.rainVolume?.trim(decimalPlaces: 1) ?? "N/A") + " mm"
        pressureLabel.text = (currentWeather.pressure?.trim(decimalPlaces: 0) ?? "N/A") + " hPA"
        windSpeedLabel.text = (currentWeather.windSpeed?.string ?? "N/A") + "km/h"
        // TODO: - Change degrees to directions
        windDirectionLabel.text = currentWeather.windDirection ?? "N/A"
    }
}

// NARK: - WeatherObservable
extension TodayModuleViewController: CurrentWeatherObservable {

    func didObtain(currentWeather: CurrentWeather) {
        configureView(for: currentWeather)
    }

    func onError() {
    }
}

// MARK: - TodayModuleViewInput
extension TodayModuleViewController: TodayModuleViewInput {

    func setupInitialState() {
        subscribe()
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
