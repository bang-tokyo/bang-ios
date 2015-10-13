//
//  APIResponse+GroupUser.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/04/21.
//  Copyright (c) 2015年 Tomoyuki Takata. All rights reserved.
//

import Foundation

extension APIResponse {
    class GroupUser: Base {
        var groupId: NSNumber!
        var userId: NSNumber!
        var facebookId: String!
        var ownerFlg: NSNumber!
        var statusValue: NSNumber!

        var status: GroupUserStatus {
            return GroupUserStatus.build(statusValue.integerValue)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "statusValue": "status"
            ]
        }
    }
}
