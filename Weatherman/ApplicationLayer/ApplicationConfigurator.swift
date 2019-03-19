//
//  ApplicationConfigurator.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

protocol ApplicationConfiguratorInput {
    func configureInitialSettings(with rootViewController: UIViewController?)
}

class ApplicationConfigurator {

    private func configureAppearance() {
    }

    private func configureFrameworks() {
    }
}

extension ApplicationConfigurator: ApplicationConfiguratorInput {

    func configureInitialSettings(with rootViewController: UIViewController?) {

        configureAppearance()
        configureFrameworks()
    }
}
