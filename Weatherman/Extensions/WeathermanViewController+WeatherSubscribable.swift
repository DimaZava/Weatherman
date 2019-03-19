//
//  WeathermanViewController+WeatherSubscribable.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation

extension WeathermanViewController: WeatherSubscribable {

    func subscribe() {
        WeatherService.sharedInstance.subscribe(self)
    }

    func unsubscribe() {
        WeatherService.sharedInstance.unsubscribe(self)
    }
}
