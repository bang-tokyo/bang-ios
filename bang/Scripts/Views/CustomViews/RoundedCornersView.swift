//
//  RoundedCornersView.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/10.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class RoundedCornersView: UIView {

    let cornerRadius: CGFloat = 8

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.makeCircle()
    }

    func makeCircle() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
