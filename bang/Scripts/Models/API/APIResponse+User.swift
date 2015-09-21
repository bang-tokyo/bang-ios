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
        var bloodTypeValue: NSNumber!
        var statusValue: NSNumber!
        var salaryCategoryId: NSNumber!
        var regionId: NSNumber!
        var region: String!
        var selfIntroduction: String!
        var selfIntroductionLong: String!
        var profileImage0: NSNumber!
        var profileImage1: NSNumber!
        var profileImage2: NSNumber!
        var profileImage3: NSNumber!
        var profileImage4: NSNumber!
        var profileImage5: NSNumber!
        var profileImagePath0: String!
        var profileImagePath1: String!
        var profileImagePath2: String!
        var profileImagePath3: String!
        var profileImagePath4: String!
        var profileImagePath5: String!
        var token: String?

        var gender: Gender {
            return Gender.build(genderValue.integerValue)
        }
        var status: UserStatus {
            return UserStatus.build(statusValue.integerValue)
        }
        var bloodType: BloodType {
            return BloodType.build(bloodTypeValue.integerValue)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "genderValue": "gender",
                "statusValue": "status",
                "bloodTypeValue": "bloodType"
            ]
        }
    }
}
