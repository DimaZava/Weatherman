//
//  ParentTabBarModuleParentTabBarModulePresenter.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

class ParentTabBarModulePresenter: ParentTabBarModuleViewOutput {

    weak var view: ParentTabBarModuleViewInput!

    func viewIsReady() {
        view.setupInitialState()
    }

    func onViewWillAppear() {
        view.onViewWillAppear()
    }
}
