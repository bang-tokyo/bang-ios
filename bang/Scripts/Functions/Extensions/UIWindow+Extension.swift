//
//  UIWindow+Extension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension UIWindow {
    func topViewController() -> UIViewController? {
        return getTopViewController(self.rootViewController)
    }

    private func getTopViewController(viewController: UIViewController?) -> UIViewController? {
        if let vc = viewController {
            if let navigationController = vc as? UINavigationController {
                return getTopViewController(navigationController.visibleViewController)
            }

            if vc.presentedViewController != nil {
                return getTopViewController(vc.presentedViewController)
            }
        }
        return viewController
    }
}
