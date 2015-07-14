//
//  APIResponse+Message.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class Message: Base {
        var message: String!
        var userId: NSNumber!
        var conversationId: NSNumber!
        var statusValue: NSNumber!

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "statusValue": "status"
            ]
        }
    }
}
