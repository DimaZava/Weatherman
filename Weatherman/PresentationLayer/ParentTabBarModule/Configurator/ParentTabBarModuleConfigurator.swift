//
//  ParentTabBarModuleParentTabBarModuleConfigurator.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class ParentTabBarModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ParentTabBarModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ParentTabBarModuleViewController) {
        let presenter = ParentTabBarModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
