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
    var forecast = Forecast() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Overrides
    override var barTitle: String? {
        return WeatherService.sharedInstance.lastTodayWeather?.city.localized()
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
        self.forecast = Forecast(with: forecast)
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return forecast.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast[section].dayWeather.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ForecastModuleTableViewHeader.desiredHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withClass: ForecastModuleTableViewHeader.self)
        let dayTitle = forecast[section].dayDate.isInToday ? "Today" : forecast[section].dayTitle
        header.configure(with: dayTitle.uppercased())
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ForecastModuleTableViewCell.self, for: indexPath)
        cell.configure(for: forecast[indexPath.section].dayWeather[indexPath.row])
        return cell
    }
}

// MARK: - ForecastModuleViewInput
extension ForecastModuleViewController: ForecastModuleViewInput {

    func setupInitialState() {

        subscribe()
        tableView.register(R.nib.forecastModuleTableViewCell)
        tableView.register(nib: UINib(resource: R.nib.forecastModuleTableViewHeader),
                           withHeaderFooterViewClass: ForecastModuleTableViewHeader.self)
        tableView.delegate = self
        tableView.dataSource = self

        if let forecast = WeatherService.sharedInstance.lastForecast {
            self.forecast = Forecast(with: forecast)
        }
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
