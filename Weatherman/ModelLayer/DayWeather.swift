//
//  DayWeather.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation
import ObjectMapper

class DayWeather: ImmutableMappable {

    let time: Date
    let weatherDescription: String?
    let icon: String?
    let temperature: Double

    enum CodingKeys: String {
        case time = "dt_txt"
        case weatherDescription = "weather.0.main"
        case icon = "weather.0.icon"
        case temperature = "main.temp"
    }

    required init(map: Map) throws {

        time = try map.value(CodingKeys.time.rawValue, using: ForecastDateTransform())
        weatherDescription = try? map.value(CodingKeys.weatherDescription.rawValue)
        if let icon: String = try? map.value(CodingKeys.icon.rawValue) {
            self.icon = "https://openweathermap.org/img/w/" + icon + ".png"
        } else {
            self.icon = nil
        }
        temperature = try map.value(CodingKeys.temperature.rawValue)
    }

    func mapping(map: Map) {
    }
}
