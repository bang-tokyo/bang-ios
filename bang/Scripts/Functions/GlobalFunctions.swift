//
//  GlobalFunctions.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/20.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

func localizedString(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func currentWindow() -> UIWindow? {
    return UIApplication.sharedApplication().delegate?.window ?? nil
}

func appDelegate() -> AppDelegate? {
    return UIApplication.sharedApplication().delegate as? AppDelegate
}

func currentTopViewController() -> UIViewController? {
    return UIApplication.sharedApplication().delegate?.window??.topViewController()
}