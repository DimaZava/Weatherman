//
//  ServiceError.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation

enum ServiceError: Error {

    case weakSelfNull
    case locationServiceDisabled

    var localizedDescription: String {
        switch self {
        case .weakSelfNull:
            return "Unable to resolve self"
        case .locationServiceDisabled:
            return "Location services are disabled. App can't obtain any information about weather in current location."
        }
    }
}
