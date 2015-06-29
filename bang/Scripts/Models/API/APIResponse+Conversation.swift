//
//  APIResponse+Conversation.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class Conversation: Base {
        var kindValue: NSNumber!
        var statusValue: NSNumber!
        var conversationUsers: [ConversationUser]!

        var kind: ConversationKind {
            return ConversationKind.build(kindValue.integerValue)
        }

        class func conversationUsersJSONTransformer() -> NSValueTransformer {
            return NSValueTransformer.mtl_JSONArrayTransformerWithModelClass(ConversationUser.self)
        }

        override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
            return [
                "kindValue": "kind",
                "statusValue": "status"
            ]
        }
    }
}
