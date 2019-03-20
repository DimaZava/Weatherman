//
//  Forecast.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation

class Forecast {

    var forecast: [DayForecast]
    var count: Int {
        return forecast.count
    }

    convenience init() {
        self.init(with: [DayWeather]())
    }

    init(with dayWeather: [DayWeather]) {

        forecast = Dictionary(grouping: dayWeather, by: { $0.time.weekday })
            .compactMap { keyValueTuple -> (Date, [DayWeather])? in

                guard let date = keyValueTuple.value.first?.time else { return nil }
                return (date, keyValueTuple.value)
            }.sorted { lhs, rhs -> Bool in
                return lhs.0 < rhs.0
            }.map { DayForecast(title: $0.0.string(withFormat: "EEEE"), date: $0.0, dayWeather: $0.1) }
    }
}

extension Forecast {

    subscript(index: Int) -> DayForecast {
        get {
            return forecast[index]
        }
        set {
            forecast.insert(newValue, at: index)
        }
    }
}

class DayForecast {

    var dayTitle: String
    var dayDate: Date
    var dayWeather: [DayWeather]

    init(title: String, date: Date, dayWeather: [DayWeather]) {
        self.dayTitle = title
        self.dayDate = date
        self.dayWeather = dayWeather
    }
}
