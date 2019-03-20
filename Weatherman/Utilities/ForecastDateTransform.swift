//
//  ForecastDateTransform.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation
import ObjectMapper

open class ForecastDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String

    public init() {}

    public func transformFromJSON (_ value: Any?) -> Date? {
        guard let datestring = value as? String else { return nil }
        let formatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss", locale: Locale.current.identifier)
        let date = formatter.date(from: datestring)
        return date
    }

    public func transformToJSON(_ value: Date?) -> String? {
        guard let stringValue = value else { return nil }
        let isoFormatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss", locale: Locale.current.identifier)
        let string = isoFormatter.string(from: stringValue)
        return string
    }
}
