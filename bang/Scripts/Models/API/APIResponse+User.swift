//
//  APIResponse+User.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class User: Base {
        var facebookId: NSNumber!
        var name: String!
        var genderValue: NSNumber!
        var statusValue: NSNumber!
        var salaryCategoryId: NSNumber!
        var token: String?

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "facebookId": "facebook_id",
                "genderValue": "gender",
                "statusValue": "status"
            ]
        }
    }
}
