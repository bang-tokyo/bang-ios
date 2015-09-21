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
        sharedInstance.show(title, message: message, labels: [localizedString("confirm")])
    }

    class func showYesNo(title: String, message: String, clicked:(()->Void)? = nil) {
        sharedInstance.show("error",
            message: message,
            labels: [localizedString("yes"), localizedString("no")],
            clicked: clicked
        )
    }

    class func showError(message: String, clicked:(()->Void)? = nil) {
        sharedInstance.show("error",
            message: message,
            labels: [localizedString("confirm")],
            clicked: clicked
        )
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

    private func show(title: String, message: String, labels: [String], clicked: (()->Void)? = nil, completion: (()->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        for (index, label) in labels.enumerate() {
            let style = index == 0 ? UIAlertActionStyle.Default : UIAlertActionStyle.Cancel
            alertController.addAction(UIAlertAction(title: label, style: style, handler: {
                (alertAction) -> Void in
                if index == 0 {
                    if let handler = clicked { handler() }
                }
                self.window.hidden = true
            }))
        }
        window.hidden = false
        let rootViewController = window.rootViewController
        rootViewController?.presentViewController(alertController, animated: true, completion: completion)
    }
}
