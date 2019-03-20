//
//  Connector.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import SwifterSwift
import UIKit

class Connector {

    static func switchToForecastModule() {
        // TODO: - Fix
//        if let parentTabController = SwifterSwift.mostTopViewController as? ParentTabBarModuleViewController,
//            let forecastModule = parentTabController
//                .viewControllers?
//                .compactMap({ ($0 as? WeathermanNavigationController)?
//                    .topViewController as? ForecastModuleViewController }).first,
//            let forecastModuleIndex = parentTabController.viewControllers?.firstIndex(of: forecastModule) {
//            parentTabController.selectedIndex = forecastModuleIndex
//        }
    }

    static func presentAlertControllerOnTopMost(alertController: UIAlertController) {
        if let parentTabController = SwifterSwift.mostTopViewController as? ParentTabBarModuleViewController,
            let navController = parentTabController.selectedViewController as? WeathermanNavigationController,
            let controller = navController.topViewController as? WeathermanViewController {
            controller.present(alertController, animated: true)
        }
    }
}
