//
//  TodayModuleTodayModuleInitializer.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class TodayModuleInitializer: NSObject {

	//Connect with object on storyboard
    @IBOutlet weak private var viewController: TodayModuleViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = TodayModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
