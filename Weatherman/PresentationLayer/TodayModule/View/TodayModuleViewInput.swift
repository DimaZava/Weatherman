//
//  TodayModuleTodayModuleViewInput.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 LetMeCode. All rights reserved.
//

protocol TodayModuleViewInput: AnyObject {

    func setupInitialState()
    func onViewWillAppear()
    func onError(_ error: Error)
}
