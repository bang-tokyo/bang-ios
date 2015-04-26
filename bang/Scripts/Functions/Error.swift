//
//  Error.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class Error {

    struct Domain {
        static let value = "com.bang.error"
    }

    enum Code: Int {
        case Unknown = 0
        case HasNoFacebookAccessToken = 1
    }

    class func create(code: Code = .Unknown) -> NSError {
        return create(code, error: nil)
    }

    class func create(code: Code, error: NSError!) -> NSError {
        var userInfo = [String: AnyObject]()
        return NSError(domain: Domain.value, code: code.rawValue, userInfo: userInfo)
    }
}
