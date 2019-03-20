//
//  ApplicationConfigurator.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Firebase
import UIKit

protocol ApplicationConfiguratorInput {

    func configureInitialSettings(with rootViewController: UIViewController?)
    func trySetupWeatherService()
}

class ApplicationConfigurator {

    private func configureAppearance() {
    }

    private func configureFrameworks() {
        // Configure Firebase services
        FirebaseApp.configure()

        // Configure weather service
        WeatherService.sharedInstance.setUp()
    }
}

extension ApplicationConfigurator: ApplicationConfiguratorInput {

    func configureInitialSettings(with rootViewController: UIViewController?) {
        configureAppearance()
        configureFrameworks()
    }

    /// Call if location access has been restored
    func trySetupWeatherService() {
        // Configure weather service
        if !LocationService.sharedInstance.locationServicesAvailable() {
            WeatherService.sharedInstance.setUp()
        }
    }
}
