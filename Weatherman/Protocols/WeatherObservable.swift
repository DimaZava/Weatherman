//
//  WeatherObservable.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

protocol WeatherObservable {
    func onError()
}

protocol CurrentWeatherObservable: WeatherObservable {
    func didObtain(currentWeather: CurrentWeather)
}

protocol ForecastWeatherObservable: WeatherObservable {
    func didObtain(forecast: [DayWeather])
}

protocol WeatherSubscribable {
    func subscribe()
    func unsubscribe()
}
