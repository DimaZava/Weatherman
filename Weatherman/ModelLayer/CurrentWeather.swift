//
//  CurrentWeather.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation
import ObjectMapper

class CurrentWeather: NSObject, Mappable, Encodable {

    var city = "N/A"
    var country = "N/A"

    var temperature: Double?
    var weatherDescription = "N/A"

    var humidity: Int?
    var rainVolume: Double?
    var pressure: Double?

    var windSpeed: Double?
    var windDegrees: Double?

    var icon: String?

    enum CodingKeys: String, CodingKey {

        case cityName = "name"
        case country = "sys.country"
        case temperature = "main.temp"
        case weatherDescription = "weather.0.main"
        case icon = "weather.0.icon"
        case humidity = "main.humidity"
        case rainVolume = "rain.1h"
        case pressure = "main.pressure"
        case windSpeed = "wind.speed"
        case windDegrees = "wind.deg"
    }

    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }

    func mapping(map: Map) {

        city <- map[CodingKeys.cityName.rawValue]
        country <- map[CodingKeys.country.rawValue]
        temperature <- map[CodingKeys.temperature.rawValue]
        weatherDescription <- map[CodingKeys.weatherDescription.rawValue]
        icon <- map[CodingKeys.icon.rawValue]
        if let icon = icon {
            self.icon = "https://openweathermap.org/img/w/" + icon + ".png"
        }
        humidity <- map[CodingKeys.humidity.rawValue]
        rainVolume <- map[CodingKeys.rainVolume.rawValue]
        pressure <- map[CodingKeys.pressure.rawValue]
        windSpeed <- map[CodingKeys.windSpeed.rawValue]
        windDegrees <- map[CodingKeys.windDegrees.rawValue]
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(city, forKey: .cityName)
        try container.encode(country, forKey: .country)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(weatherDescription, forKey: .weatherDescription)
        try container.encode(humidity, forKey: .humidity)
        try container.encode(pressure, forKey: .pressure)
        try container.encode(windSpeed, forKey: .windSpeed)
        try container.encode(windDegrees, forKey: .windDegrees)
    }
}
