//
//  DayWeather.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation
import ObjectMapper

class DayWeather: NSObject, Mappable {

    var time: Date?
    var weatherDescription = "N/A"
    var icon: String?
    var temperature: Int?

    enum CodingKeys: String {
        case time = "dt_txt"
        case weatherDescription = "weather.0.main"
        case icon = "weather.0.icon"
        case temperature = "main.temp"
    }

    required init?(map: Map) {

        super.init()
        time <- (map[CodingKeys.time.rawValue], ForecastDateTransform())
        weatherDescription <- map[CodingKeys.weatherDescription.rawValue]
        icon <- map[CodingKeys.icon.rawValue]
        temperature <- map[CodingKeys.temperature.rawValue]

        guard time != nil else { return nil }
    }

    func mapping(map: Map) {
    }
}
