//
//  ForecasModuleForecastModuleConfigurator.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class ForecastModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ForecastModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ForecastModuleViewController) {
        let presenter = ForecastModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
