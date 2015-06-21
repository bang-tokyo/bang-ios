//
//  APIResponse+BangRequestedList.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/07.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class UserBang: Base {
        var fromUserId: NSNumber!
        var itemId: NSNumber!
        var statusValue: NSNumber!
        var fromUser: User!

        var status: BangStatus {
            return BangStatus.build(statusValue.integerValue)
        }

        class func fromUserJSONTransformer() -> NSValueTransformer {
            return APIResponse.modelClassJSONTransformer(User.self)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "statusValue": "status"
            ]
        }
    }
}
