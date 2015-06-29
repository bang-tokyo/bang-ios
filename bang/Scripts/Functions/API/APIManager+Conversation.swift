//
//  APIManager+Conversation.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func showConversation(id: Int) -> BFTask {
        return request(.GET, path: "/v1/conversations/\(id)").APIErrorHandler()
    }

    func conversationList() -> BFTask {
        return request(.GET, path: "/v1/conversations").APIErrorHandler()
    }

    func sendMessage(id: Int, message: String) -> BFTask {
        return request(.POST, path: "/v1/conversations/\(id)/message", parameters: [
            "message": message
        ])
    }
}
