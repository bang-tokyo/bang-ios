//
//  APIResponse+ConversationUser.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class ConversationUser: Base {
        var conversationId: NSNumber!
        var userId: NSNumber!
        var user: User!

        class func userJSONTransformer() -> NSValueTransformer {
            return APIResponse.modelClassJSONTransformer(User.self)
        }
    }
}
