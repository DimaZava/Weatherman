//
//  WeathermanViewController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Dodo
import SwifterSwift
import UIKit

public protocol TransitionController: AnyObject {

    var isCanPop: Bool { get }

    func dismissModule(animated: Bool)
}

public class WeathermanViewController: UIViewController, NavigationBarDataSource, NavigationBarStyleDataSource {

    public class NavigationBarDefaultStyle: NavigationBarStyleDataSource {

        public var isDefaultBackButtonHidden: Bool = false
        public var isNavigationBarHidden: Bool = false
        public var isBackActionAnimated: Bool = true
        public var isLargeTitlePreferred: Bool = false
        public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .never
    }

    public override var navigationController: WeathermanNavigationController? {
        return super.navigationController as? WeathermanNavigationController
    }

    var activityIndicator: UIActivityIndicatorView?

    public var barTitle: String? {
        return nil
    }

    public var isDefaultBackButtonHidden: Bool {
        return navigationBarStyle.isDefaultBackButtonHidden
    }

    public var isNavigationBarHidden: Bool {
        return navigationBarStyle.isNavigationBarHidden
    }

    public var isBackActionAnimated: Bool {
        return navigationBarStyle.isBackActionAnimated
    }

    public var isLargeTitlePreferred: Bool {
        return navigationBarStyle.isLargeTitlePreferred
    }

    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        return navigationBarStyle.largeTitleDisplayMode
    }

    //fileprivate var loadFace: UIView?
    //fileprivate var tappedAroundDelegate: HideKeyboardWhenTappedAroundDelegate?
    fileprivate let navigationBarStyle = NavigationBarDefaultStyle()
    //fileprivate var loadingMoreActivityIndicatorView: ActivityIndicatorView?

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    public override func viewDidLoad() {

        super.viewDidLoad()
        //navigationController?.barStyleDataSource = navigationBarStyle
        UIApplication.shared.keyWindow?.backgroundColor = view.backgroundColor
    }

    public override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        navigationController?.barDataSource = self
        navigationController?.barStyleDataSource = self
        setupDodo()
    }

    public func backItem(for navigationBar: UINavigationBar) -> UIBarButtonItem? {

        let childsCount = navigationController?.viewControllers.count ?? 0
        let backItem = UIBarButtonItem(image: R.image.nav_bar_back()?.withRenderingMode(.alwaysOriginal),
                                       style: .plain,
                                       target: self,
                                       action: #selector(dismissModuleWithAnimation))

        if childsCount > 1 || parent?.presentingViewController != nil || parent?.popoverPresentationController != nil {
            return backItem
        }
        return nil
    }

    public func leftItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]? {
        return nil
    }

    public func rightItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]? {
        return nil
    }

    func setupDodo() {

        if #available(iOS 11, *) {
            view.dodo.topAnchor = view.safeAreaLayoutGuide.topAnchor
            view.dodo.bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            view.dodo.topAnchor = topLayoutGuide.bottomAnchor
            view.dodo.bottomAnchor = bottomLayoutGuide.topAnchor
        }

        view.dodo.style.bar.hideAfterDelaySeconds = 3.0
        view.dodo.style.label.font = UIFont.systemFont(ofSize: 16.0, weight: .light)

        view.dodo.style.bar.onTap = { [weak self] in
            self?.view.dodo.hide()
        }
    }

    func showSuccessView(text: String = "Operation Successfull!") {

        view.dodo.preset = DodoPresets.success
        view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
        view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
        view.dodo.show(text)
    }

    func showProgressView(text: String = "Loading...") {

        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }

    func showErrorView(text: String = "Something goes wrong!", onTap: (() -> Void)? = nil) {

        view.dodo.style.bar.onTap = { [weak self] in
            onTap?()
            self?.view.dodo.hide()
        }

        DispatchQueue.main.async { [weak self] in
            self?.view.dodo.preset = DodoPresets.error
            self?.view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
            self?.view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
            self?.view.dodo.show(text)
        }
    }

    func presentShareController(sourceView: UIAppearance, text: String, image: UIImage?) {

        var shareAll = [text] as [Any]
        if let image = image {
            shareAll.append(image)
        }

        //APPEARANCE WORKAROUND
        let uiBarButtonAppearance = UIBarButtonItem.appearance()
        let previousColorNormal = uiBarButtonAppearance.titleTextAttributes(for: .normal)
        let previousColorHighlighted = uiBarButtonAppearance.titleTextAttributes(for: .highlighted)

        uiBarButtonAppearance.setTitleTextAttributes([.foregroundColor: R.color.primaryBlue()!],
                                                     for: .normal)
        uiBarButtonAppearance.setTitleTextAttributes([.foregroundColor: R.color.primaryBlue()!],
                                                     for: .highlighted)

        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        //activityViewController.popoverPresentationController?.sourceView = self.view

        if SwifterSwift.isPad {
            if let sourceView = sourceView as? UIView {
                activityViewController.popoverPresentationController?.sourceView = sourceView
                activityViewController.popoverPresentationController?.sourceRect = sourceView.bounds
            } else if let sourceBarButtonItem = sourceView as? UIBarButtonItem {
                activityViewController.popoverPresentationController?.barButtonItem = sourceBarButtonItem
            }
        }

        activityViewController.completionWithItemsHandler = { activity, completed, items, error in

            if let previousColorNormal = previousColorNormal?[.foregroundColor],
                let previousColorHighlighted = previousColorHighlighted?[.foregroundColor] {
                uiBarButtonAppearance.setTitleTextAttributes([.foregroundColor: previousColorNormal],
                                                             for: .normal)
                uiBarButtonAppearance.setTitleTextAttributes([.foregroundColor: previousColorHighlighted],
                                                             for: .highlighted)
            }

            if !completed || error != nil {
                return
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }

    func sharingDescription(for activity: UIActivity.ActivityType?) -> String {

        if let activity = activity {

            switch activity {
            case UIActivity.ActivityType.airDrop,
                 UIActivity.ActivityType.copyToPasteboard,
                 UIActivity.ActivityType.mail,
                 UIActivity.ActivityType.addToReadingList,
                 UIActivity.ActivityType.message,
                 UIActivity.ActivityType.postToFacebook,
                 UIActivity.ActivityType.postToTwitter,
                 UIActivity.ActivityType.postToFlickr,
                 UIActivity.ActivityType.postToTencentWeibo,
                 UIActivity.ActivityType.postToWeibo,
                 UIActivity.ActivityType.print,
                 UIActivity.ActivityType.saveToCameraRoll:
                return activity.rawValue
            default:
                if let lastPartOfActivity = activity.rawValue.split(separator: ".").last {
                    return String(lastPartOfActivity)
                }
            }
        }

        return ""
    }

    @objc
    func dismissModuleWithAnimation() {
        dismissModule(animated: true)
    }
}

extension WeathermanViewController: TransitionController {

    public var isCanPop: Bool {

        guard let navigationController = parent as? UINavigationController,
            !navigationController.viewControllers.isEmpty else { return false }
        return navigationController.viewControllers.first != self
    }

    @objc
    public func dismissModule(animated: Bool) {
        switch parent {
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty &&
            navigationController.viewControllers.first != self:
            navigationController.popViewController(animated: animated)
        case _ where parent?.presentingViewController != nil || parent?.popoverPresentationController != nil:
            dismiss(animated: animated)
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty:
            navigationController.popViewController(animated: animated)
        default:
            dismiss(animated: animated)
        }
    }

    @objc
    public func dismissToRoot(animated: Bool) {
        switch parent {
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty &&
            navigationController.viewControllers.first != self:
            navigationController.popToRootViewController(animated: animated)
        case _ where parent?.presentingViewController != nil || parent?.popoverPresentationController != nil:
            dismiss(animated: animated)
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty:
            navigationController.popToRootViewController(animated: animated)
        default:
            dismiss(animated: animated)
        }
    }
}
