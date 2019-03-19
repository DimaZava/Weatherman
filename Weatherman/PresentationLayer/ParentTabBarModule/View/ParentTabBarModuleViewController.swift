//
//  ParentTabBarModuleParentTabBarModuleViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import SwifterSwift
import UIKit

class ParentTabBarModuleViewController: UITabBarController {

    // MARK: - Outlets
	//@IBOutlet weak private var tableView: UITableView!

    // MARK: - Constants

    // MARK: - Properties
    var output: ParentTabBarModuleViewOutput!
    let tabBarItemIcons: [UIImage] = {
        return [R.image.today()!,
                R.image.forecast()!]
    }()

    let tabBarControllerContentControllers: [UIViewController] = {

        guard let todayModuleViewController = R.storyboard.todayModuleViewController()
            .instantiateInitialViewController() else {
                fatalError("Unable to instantiate TodayModuleViewController")
        }

        guard let forecastModuleViewController = R.storyboard.forecastModuleViewController()
            .instantiateInitialViewController() else {
                fatalError("Unable to instantiate ForecastModuleViewController")
        }
        return [todayModuleViewController,
                forecastModuleViewController]
    }()

    // MARK: - Overrides

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.onViewWillAppear()
    }

    // MARK: - Actions

    // MARK: - Other
}

// MARK: - ParentTabBarModuleViewInput
extension ParentTabBarModuleViewController: ParentTabBarModuleViewInput {

    func setupInitialState() {

        viewControllers = tabBarControllerContentControllers
        let offset: CGFloat = !SwifterSwift.isPad ? 6.0 : 0.0
        tabBar.items?.forEach({ barItem in
            barItem.image = tabBarItemIcons[tabBar.items!.index(of: barItem)!]
            barItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        })
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
