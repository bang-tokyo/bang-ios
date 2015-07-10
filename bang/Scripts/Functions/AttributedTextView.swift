//
//  BangTextView.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/10.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import SECoreTextView

class AttributedTextView: SETextView {
    func hasSetAttributes(text: String) -> Bool {
        return attributedText != nil && attributedText.string == text
    }
}