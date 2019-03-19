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

    var localizedDescription: String {
        switch self {
        case .weakSelfNull:
            return "Unable to resolve self"
        }
    }
}
