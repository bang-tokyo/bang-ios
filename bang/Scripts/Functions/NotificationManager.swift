//
//  NotificationManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/26.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum Notification: String {
    case ConversationDetailWillShow = "Notification/ConversationDetailWillShow"
}

class NotificationManager {
    class func notifyConversationDetailWillShow(conversationId: Int) {
        let parameters:[String:Int] = ["conversationId": conversationId]
        postNotification(Notification.ConversationDetailWillShow, parameters: parameters)
    }
}

// MARK: - Praivate functions
extension NotificationManager {
    private class func postNotification(notification: Notification, parameters: [NSObject: AnyObject]?) {
        let n = NSNotification(name: notification.rawValue, object: nil, userInfo: parameters)
        NSNotificationCenter.defaultCenter().postNotification(n)
    }
}