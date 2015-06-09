//
//  Alert.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/26.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class Alert: NSObject {
    private var _window: UIWindow! = nil

    class func showNormal(title: String, message: String) {
        sharedInstance.show(title, message: message)
    }

    class func showError(message: String, clicked:(()->Void)? = nil) {
        sharedInstance.show("error", message: message, clicked: clicked)
    }
}

// MARK: - Praivate functions
extension Alert {

    private class var sharedInstance: Alert {
        struct Static {
            static let instance = Alert()
        }
        return Static.instance
    }

    private var window: UIWindow {
        if (_window == nil) {
            _window = UIWindow(frame: UIApplication.sharedApplication().keyWindow!.frame)
            _window.windowLevel = UIWindowLevelAlert
            _window.rootViewController = UIViewController()
            _window.makeKeyAndVisible()
        }
        return _window
    }

    private func show(title: String, message: String, clicked: (()->Void)? = nil, completion: (()->Void)? = nil) {
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(
            title: NSLocalizedString("confirm", comment: ""),
            style: .Default,
            handler: nil
        ))
        window.hidden = false
        var rootViewController = window.rootViewController
        rootViewController?.presentViewController(alertController, animated: true, completion: completion)
    }
}
