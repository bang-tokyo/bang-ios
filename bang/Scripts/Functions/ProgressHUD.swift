//
//  ProgressHUD.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressHUD {
    class func show() {
        GCD.runOnMainThread({
            SVProgressHUD.show()
        })
    }

    class func hide() {
        GCD.runOnMainThread({
            SVProgressHUD.dismiss()
        })
    }
}
