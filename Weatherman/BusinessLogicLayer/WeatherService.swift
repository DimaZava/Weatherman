//
//  WeatherService.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import CoreLocation

class WeatherService {

    // MARK: - Static members
    static let sharedInstance = WeatherService()

    // MARK: - Properties
    var subscribers = Set<WeathermanViewController>()
    let apiKey = "2026a168593b8edb0286fd043a7fb005"

    // MARK: - Lifecycle
    private init() { }

    func setUp() {
        LocationService.sharedInstance.configureLocationManager { status in
            LocationService.sharedInstance.delegate = self
            if case .authorizedWhenInUse = status {
                LocationService.sharedInstance.startUpdatingLocation()
            }
        }
    }

    func subscribe(_ subscriber: WeathermanViewController) {
        subscribers.insert(subscriber)
    }

    func unsubscribe(_ subscriber: WeathermanViewController) {
        subscribers.remove(subscriber)
    }
}

extension WeatherService: LocationServiceDelegate {

    func didUpdateLocation(_ location: CLLocation) {
        APIService.sharedInstance
            .obtainCurrentWeather(for: location,
                           success: { [weak self] result in

                            guard let self = self else { Logger.log(ServiceError.weakSelfNull); return }
                            self.subscribers.forEach { controller in
                                if let observer = controller as? WeatherObservable {
                                    observer.didObtainWeather()
                                }
                            }
                },
                           failure: { error in
                            Logger.log(error)
            })
    }
}
