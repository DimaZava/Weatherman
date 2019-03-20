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

    // MARK: - Constants
    let apiKey = "2026a168593b8edb0286fd043a7fb005"

    // MARK: - Properties
    var subscribers = Set<WeathermanViewController>()
    var lastTodayWeather: CurrentWeather?
    var lastForecast: [DayWeather]?

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
                                  success: { [weak self] currentWeather in

                                    guard let self = self else { Logger.log(ServiceError.weakSelfNull); return }
                                    self.lastTodayWeather = currentWeather
                                    self.subscribers
                                        .compactMap { $0 as? CurrentWeatherObservable }
                                        .forEach { $0.didObtain(currentWeather: currentWeather) }
                                    Storage.sharedInstance.add(userData: UserData(currentWeather: currentWeather,
                                                                                  currentLocation: location))
                },
                                  failure: { error in
                                    Logger.log(error)
            })

        APIService.sharedInstance
            .obtainForecastWeather(for: location,
                                   success: { [weak self] forecast in

                                    guard let self = self else { Logger.log(ServiceError.weakSelfNull); return }
                                    self.lastForecast = forecast
                                    self.subscribers
                                        .compactMap { $0 as? ForecastWeatherObservable }
                                        .forEach { $0.didObtain(forecast: forecast) }
                },
                                   failure: { error in
                                    Logger.log(error)
            })
    }
}
