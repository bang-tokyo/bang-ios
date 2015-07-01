//
//  NSNotificationCenter+Extension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    func replaceObserver(observer: AnyObject, selector: Selector, name: String) {
        removeObserver(observer, name: name, object: nil)
        addObserver(observer, selector: selector, name: name, object: nil)
    }
}