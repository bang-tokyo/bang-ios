//
//  BangTextView.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/10.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import TTTAttributedLabel

class AttributedLabel: TTTAttributedLabel {
    private struct Const {
        static let LineSpacing: CGFloat = -5.0
        static let lineHeightMultiple: CGFloat = 0.8
    }

    func configure(text: String?, _ style: Style.Label) {
        configure(text, style, nil, nil)
    }

    func configure(text: String?, _ style: Style.Label, _ maxWidth: CGFloat?) {
        configure(text, style, maxWidth, nil)
    }

    func configure(text: String?, _ style: Style.Label, _ maxWidth: CGFloat?, _ attributes: [String: NSObject]?) {
        if let t = style.textColor {
            textColor = t
        }
        configure(text, style.font, maxWidth, attributes)
    }

    func configure(text: String?, _ font: UIFont?, _ maxWidth: CGFloat?, _ attributes: [String: NSObject]?) {

        if let m = maxWidth {
            preferredMaxLayoutWidth = m
        }

        lineSpacing = Const.LineSpacing
        lineHeightMultiple = Const.lineHeightMultiple

        if let t = text {
            setText(text, afterInheritingLabelAttributesAndConfiguringWithBlock: {
                (attributedString) -> NSMutableAttributedString! in

                if let f = font {
                    attributedString.addAttribute(NSFontAttributeName, value: f, range: NSMakeRange(0, t.utf16.count))
                }

                if let items = attributes {
                    for (key, value) in items {
                        attributedString.addAttribute(key, value: value, range: NSMakeRange(0, t.utf16.count))
                    }
                }

                return attributedString
            })
        }
    }
}
