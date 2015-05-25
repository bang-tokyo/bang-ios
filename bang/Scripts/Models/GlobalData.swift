//
//  GlobalData.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class GlobalData {

    class var sharedInstance: GlobalData {
        struct Static {
            static let instance = GlobalData()
        }
        return Static.instance
    }

    let prefix = "globalData."

    var facebookUserData: NSDictionary? {
        get {
            return userDefault().dictionaryForKey(prefix+"facebookUserData")
        }
        set {
            userDefault().setValue(newValue, forKey: prefix+"facebookUserData")
            userDefault().synchronize()
        }
    }

}

// MARK: - Private functions
extension GlobalData {
    private func userDefault() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
}
