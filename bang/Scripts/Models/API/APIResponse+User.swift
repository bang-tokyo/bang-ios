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
        var facebookId: String!
        var name: String!
        var birthday: String!
        var genderValue: NSNumber!
        var statusValue: NSNumber!
        var salaryCategoryId: NSNumber!
        var token: String?

        var gender: Gender {
            return Gender.build(genderValue.integerValue)
        }
        var status: UserStatus {
            return UserStatus.build(statusValue.integerValue)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "genderValue": "gender",
                "statusValue": "status"
            ]
        }
    }
}
