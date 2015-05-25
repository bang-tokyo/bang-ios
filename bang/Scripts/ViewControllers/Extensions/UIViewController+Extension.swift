//
//  UIViewControllerExtension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

extension UIViewController {

    func moveTo(viewController: UIViewController) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }

    func moveToInNavigationController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func backPrevViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func closeViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func setBlurBackground() {
        if let parentViewController = self.presentingViewController {
            self.view.setBlurBackground(parentViewController.view)
        }
    }

    func closeModalWindow() {
        AppDelegate.sharedAppDelegate()?.closeModalWindow()
    }

    func addBackButton() {
        if let navigationController = self.navigationController {
            var buttonItem = UIBarButtonItem(
                image: UIImage(named: ""),
                style: .Plain,
                target: self,
                action: Selector("backPrevViewController")
            )
            self.navigationItem.leftBarButtonItem = buttonItem
            self.navigationController?.interactivePopGestureRecognizer.delegate = self
        }
    }

    func addCloseButton() {
        if let navigationController = self.navigationController {
            var buttonItem = UIBarButtonItem(
                image: UIImage(named: ""),
                style: .Plain,
                target: self,
                action: Selector("closeViewController")
            )
            buttonItem.title = "Close"
            self.navigationItem.leftBarButtonItem = buttonItem
            self.navigationController?.interactivePopGestureRecognizer.delegate = self
        }
    }
}

extension UIViewController:UIGestureRecognizerDelegate {
}
