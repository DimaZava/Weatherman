//
//  ForecasModuleForecastModuleViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class ForecastModuleViewController: UIViewController {

    // MARK: - Outlets
	//@IBOutlet weak private var tableView: UITableView!

    // MARK: - Constants

    // MARK: - Properties
    var output: ForecastModuleViewOutput!

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

// MARK: - ForecastModuleViewInput
extension ForecastModuleViewController: ForecastModuleViewInput {

    func setupInitialState() {
    }

    func onViewWillAppear() {
    }

	func onError(_ error: Error) {
    }
}
