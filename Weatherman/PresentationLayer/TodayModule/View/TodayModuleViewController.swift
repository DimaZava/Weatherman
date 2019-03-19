//
//  TodayModuleTodayModuleViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class TodayModuleViewController: WeathermanViewController {

    // MARK: - Outlets

    // MARK: - Constants

    // MARK: - Properties
    var output: TodayModuleViewOutput!

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

    // MARK: - Other
}

// NARK: - WeatherObservable
extension TodayModuleViewController: WeatherObservable {

    func didObtainWeather() {
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
