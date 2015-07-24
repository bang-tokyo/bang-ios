//
//  Style.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/11.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

struct Style {
    class Label {
        let textColor: UIColor?
        let font: UIFont?

        init(textColor: UIColor?, font: UIFont?) {
            self.textColor = textColor
            self.font = font
        }
    }
}

extension Style {
    static let MessageLabel = Label(textColor: UIColor.hexColor(0x666666FF), font: UIFont.hirakakuProNW3(15.0))
}
