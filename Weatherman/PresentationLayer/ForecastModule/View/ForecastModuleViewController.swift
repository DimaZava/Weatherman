//
//  ForecasModuleForecastModuleViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class ForecastModuleViewController: WeathermanViewController {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Constants

    // MARK: - Properties
    var output: ForecastModuleViewOutput!
    var forecast = [DayWeather]()

    // MARK: - Overrides
    override var barTitle: String? {
        // TODO: - Change to current city name
        return "City".localized()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    deinit {
        unsubscribe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.onViewWillAppear()
    }

    // MARK: - Actions

    // MARK: - Other
}

// NARK: - WeatherObservable
extension ForecastModuleViewController: ForecastWeatherObservable {

    func didObtain(forecast: [DayWeather]) {
        self.forecast = forecast
        tableView.reloadData()
    }

    func onError() {
    }
}

// MARK: - UITableViewDelegate
extension ForecastModuleViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension ForecastModuleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withClass: ForecastModuleTableViewCell.self, for: indexPath)
        cell.configure(for: forecast[indexPath.row])
        return cell
    }
}

// MARK: - ForecastModuleViewInput
extension ForecastModuleViewController: ForecastModuleViewInput {

    func setupInitialState() {
        subscribe()

        tableView.register(R.nib.forecastModuleTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
