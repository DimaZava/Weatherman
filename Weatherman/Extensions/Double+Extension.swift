//
//  Double+Extension.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation

extension Double {

    func trim(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
