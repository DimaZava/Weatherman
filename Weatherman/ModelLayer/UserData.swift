//
//  UserData.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import CoreLocation
import UIKit

final class UserData: Encodable {

    let userId = UIDevice.current.identifierForVendor!
    let currentWeather: CurrentWeather
    let currentLocation: [String: CLLocationDegrees]

    init(currentWeather: CurrentWeather, currentLocation: CLLocation) {
        self.currentWeather = currentWeather
        self.currentLocation = ["lat": currentLocation.coordinate.latitude,
                                "lon": currentLocation.coordinate.longitude]
    }

    enum CodingKeys: String, CodingKey {

        case userId
        case currentWeather
        case currentLocation
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(currentWeather, forKey: .currentWeather)
        try container.encode(currentLocation, forKey: .currentLocation)
    }
}
