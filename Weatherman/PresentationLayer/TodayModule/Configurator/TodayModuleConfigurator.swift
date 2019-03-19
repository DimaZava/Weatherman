//
//  TodayModuleTodayModuleConfigurator.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class TodayModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? TodayModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TodayModuleViewController) {
        let presenter = TodayModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
