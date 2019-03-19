//
//  WeatherObservable.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

protocol WeatherObservable {

    func didObtainWeather()
    func onError()
}

protocol WeatherSubscribable {

    func subscribe()
    func unsubscribe()
}
