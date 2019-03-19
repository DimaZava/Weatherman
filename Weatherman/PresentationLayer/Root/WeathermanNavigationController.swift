//
//  WeathermanNavigationController.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

// MARK: - Navigation Controller Data Source Protocol
public protocol NavigationBarDataSource: AnyObject {

    var barTitle: String? { get }
    var isLargeTitlePreferred: Bool { get }
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get }

    func backItem(for navigationBar: UINavigationBar) -> UIBarButtonItem?
    func leftItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]?
    func rightItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]?
}

// MARK: - Navigation Controller Style Data Source Protocol
public protocol NavigationBarStyleDataSource: AnyObject {

    var isDefaultBackButtonHidden: Bool { get }
    var isNavigationBarHidden: Bool { get }
    var isBackActionAnimated: Bool { get }
    var isLargeTitlePreferred: Bool { get }
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get }
}

@IBDesignable
public class WeathermanNavigationController: UINavigationController {

    // MARK: - Navigation bar Style
    public enum NavigationBarStyle: Int {
        case transparent
        case shadowed
        case solid
        case gradient
    }

    // MARK: - Overrides
    override public var childForStatusBarStyle: UIViewController? {
        //return visibleViewController
        return topViewController
    }

    // MARK: - Properties
    public override var viewControllers: [UIViewController] {
        didSet {
            performNeedsUpdates()
        }
    }

    override public var previewActionItems: [UIPreviewActionItem] {
        return topViewController?.previewActionItems ?? []
    }

    public weak var barDataSource: NavigationBarDataSource? {
        didSet {
            reloadBarDataSource()
        }
    }

    public weak var barStyleDataSource: NavigationBarStyleDataSource? {
        didSet {
            reloadBarStyle()
        }
    }

    public func reloadBarStyle() {

        guard let barStyleDataSource = barStyleDataSource else { return }

        navigationBar.isHidden = barStyleDataSource.isNavigationBarHidden

        guard let last = self.viewControllers.last else { return }
        last.navigationItem.hidesBackButton = barStyleDataSource.isDefaultBackButtonHidden
        //        navigationBar.barTintColor = barStyleDataSource.barTintColor
        //        navigationBar.tintColor = barStyleDataSource.tintColor
        //        navigationBar.backgroundColor = barStyleDataSource.navigationBarColor
        //        navigationBar.titleTextAttributes = [.font: barStyleDataSource.barTitleFont,
        //        .foregroundColor: barStyleDataSource.barTitleColor]
        //
        //        let backgroundImage = UIImage(color: barStyleDataSource.navigationBarColor)
        //
        //        switch barStyleDataSource.barStyle {
        //
        //        case .transparent:
        //            navigationBar.isTranslucent = true
        //            navigationBar.setBackgroundImage(backgroundImage, for: .default)
        //            navigationBar.shadowImage = UIImage()
        //        case .shadowed:
        //            navigationBar.isTranslucent = false
        //            navigationBar.setBackgroundImage(backgroundImage, for: .default)
        //            navigationBar.shadowImage = UIImage()
        //            navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        //            navigationBar.layer.shadowRadius = 4
        //            navigationBar.layer.shadowColor = UIColor.black.cgColor
        //            navigationBar.layer.shadowOpacity = 0.1
        //            navigationBar.layer.masksToBounds = false
        //        case .solid:
        //            navigationBar.isTranslucent = false
        //            navigationBar.barStyle = .blackTranslucent
        //            navigationBar.setBackgroundImage(backgroundImage, for: .default)
        //            navigationBar.setBackgroundImage(backgroundImage, for: .compactPrompt)
        //            navigationBar.shadowImage = UIImage()
        //            navigationBar.layer.shadowOpacity = 0.0
        //        case .gradient:
        //            navigationBar.isTranslucent = true
        //            var navigationFrame = navigationBar.bounds
        //            if #available(iOS 11.0, *) {
        //
        //                navigationFrame.size.height += view.safeAreaInsets.top
        //            }
        //            else {
        //
        //                navigationFrame.size.height += topLayoutGuide.length
        //            }
        //            guard let image = gradientImage(for: navigationFrame,
        //        with: barStyleDataSource.navigationBarColor) else { return }
        //            navigationBar.setBackgroundImage(image, for: .default)
        //            navigationBar.shadowImage = UIImage()
        //        }
    }

    public func reloadBarDataSource() {

        self.navigationBar.prefersLargeTitles = self.barDataSource?.isLargeTitlePreferred ?? false
        self.navigationItem.largeTitleDisplayMode = self.barDataSource?.largeTitleDisplayMode ?? .never
        //navigationBar.largeTitleTextAttributes =
        //    [.foregroundColor: UIColor(red: 31 / 255,
        //                               green: 186 / 255,
        //                               blue: 187 / 255,
        //                               alpha: 1.0),
        //     .font: R.font.sfProDisplayBold(size: 34.0) as Any]

        guard let last = self.viewControllers.last else { return }

        last.navigationItem.title = self.barDataSource?.barTitle
        last.navigationItem.leftBarButtonItems = self.barDataSource?.leftItems(for: self.navigationBar)
        last.navigationItem.rightBarButtonItems = self.barDataSource?.rightItems(for: self.navigationBar)

        guard let backItem = self.barDataSource?.backItem(for: self.navigationBar) else { return }

        last.navigationItem.hidesBackButton = true
        if last.navigationItem.leftBarButtonItems != nil {
            last.navigationItem.leftBarButtonItems?.insert(backItem, at: 0)
        } else {
            last.navigationItem.leftBarButtonItems = [backItem]
        }
    }

    // MARK: - Private methods
    private func performNeedsUpdates() {
        reloadBarStyle()
        reloadBarDataSource()
    }

    private func gradientImage(for frame: CGRect, with color: UIColor) -> UIImage? {

        let gradient = CAGradientLayer()
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = frame
        gradient.colors = [color.cgColor, color.withAlphaComponent(0.01).cgColor]

        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
