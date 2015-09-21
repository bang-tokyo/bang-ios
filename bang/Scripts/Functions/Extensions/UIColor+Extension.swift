//
//  UIColor+Extension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/11.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // hex: "0x5B615FFF" or "0xFFFFFFFF" like this.
    class func hexColor(hex: UInt32) -> UIColor {
        let red = CGFloat(((hex & 0xff000000) >> 24))/255.0
        let green = CGFloat(((hex & 0x00ff0000) >> 16))/255.0
        let blue = CGFloat(((hex & 0x0000ff00) >> 8))/255.0
        let alpha = CGFloat((hex & 0x000000ff))/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    // red: 255, green: 255, blue: 255
    class func hexColor(red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor.hexColor(red, green, blue, 1.0)
    }

    // red: 255, green: 255, blue: 255, alpha: 1.0
    class func hexColor(red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        let _red = CGFloat(red)/255.0
        let _green = CGFloat(green)/255.0
        let _blue = CGFloat(blue)/255.0
        return UIColor(red: _red, green: _green, blue: _blue, alpha: alpha)
    }
}
