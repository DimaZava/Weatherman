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

    // MARK: - Properties
    var city = "N/A"
    var country = "N/A"

    var temperature: Double?
    var weatherDescription = "N/A"

    var humidity: Int?
    var rainVolume: Double?
    var pressure: Double?

    var windSpeed: Double?
    var windDegrees: Double?

    var windDirection: String? {
        guard let windDegrees = windDegrees else { return nil }
        let value = ((windDegrees / 22.5) + 0.5).floor
        var arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let sideIndex = value.truncatingRemainder(dividingBy: 16).int
        return arr[sideIndex]
    }

    var icon: String?

    var stringRepresentation: String {
        return """
        Hello! I'd like to share with you current weather nearby:
        \(city), \(country)
        temperature: \(temperature?.trim(decimalPlaces: 0) ?? "" + "℃ | " + weatherDescription)
        humidity: \(humidity?.string ?? "N/A" + "%")
        rain volume: \((rainVolume?.trim(decimalPlaces: 1) ?? "N/A") + " mm")
        pressure: \((pressure?.trim(decimalPlaces: 0) ?? "N/A") + " hPA")
        wind speed: \((windSpeed?.string ?? "N/A") + "km/h")
        wind direction: \(windDirection ?? "N/A")
        """
    }

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

    // MARK: - Lifecycle
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
