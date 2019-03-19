//
//  ParentTabBarModuleParentTabBarModuleInitializer.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

import UIKit

class ParentTabBarModuleInitializer: NSObject {

	//Connect with object on storyboard
    @IBOutlet weak private var viewController: ParentTabBarModuleViewController!

    override func awakeFromNib() {
    	super.awakeFromNib()
        let configurator = ParentTabBarModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
