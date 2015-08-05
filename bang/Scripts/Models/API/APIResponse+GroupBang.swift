//
//  APIResponse+BangRequestedList.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/06/07.
//  Copyright (c) 2015年 Tomoyuki Takata. All rights reserved.
//

import Foundation

extension APIResponse {
    class GroupBang: Base {
        var fromGroupId: NSNumber!
        var itemId: NSNumber!
        var statusValue: NSNumber!
        var fromGroup: Group!

        var status: BangStatus {
            return BangStatus.build(statusValue.integerValue)
        }

        class func fromGroupJSONTransformer() -> NSValueTransformer {
            return APIResponse.modelClassJSONTransformer(Group.self)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "statusValue": "status"
            ]
        }
    }
}
