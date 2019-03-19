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

    // MARK: - Constants

    // MARK: - Properties
    var output: ForecastModuleViewOutput!

    // MARK: - Overrides
    override var barTitle: String? {
        return "City_RENAME!!!!".localized()
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
extension ForecastModuleViewController: WeatherObservable {

    func didObtainWeather() {
    }

    func onError() {
    }
}

// MARK: - ForecastModuleViewInput
extension ForecastModuleViewController: ForecastModuleViewInput {

    func setupInitialState() {
        subscribe()
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
