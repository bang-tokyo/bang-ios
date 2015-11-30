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
    case GroupDetailWillShow = "Notification/GroupDetailWillShow" //グループ詳細画面表示時
    case GroupDetailInfoWillShow = "Notification/GroupDetailInfoWillShow" //グループ詳細情報表示時
    case FacebookFriendWillShow = "Notification/FacebookFriendWillShow"
}

class NotificationManager {
    class func notifyConversationDetailWillShow(conversationId: Int) {
        let parameters:[String:Int] = ["conversationId": conversationId]
        postNotification(Notification.ConversationDetailWillShow, parameters: parameters)
    }

    class func notifyGroupDetailWillShow(groupId: Int) {
        let parameters:[String:Int] = ["groupId": groupId]
        postNotification(Notification.GroupDetailWillShow, parameters: parameters)
    }

    class func notifyGroupDetailInfoWillShow(group: APIResponse.Group) {
        let parameters:[String:APIResponse.Group]? = ["group": group]
        postNotification(Notification.GroupDetailInfoWillShow, parameters: parameters)
    }

    class func notifyFacebookFriendWillShow(facebookFriends: [APIResponse.Facebook.FriendUser]) {
        let parameters:[String:[APIResponse.Facebook.FriendUser]]? = ["facebookFriends": facebookFriends]
        postNotification(Notification.FacebookFriendWillShow, parameters: parameters)
    }
}

// MARK: - Praivate functions
extension NotificationManager {
    private class func postNotification(notification: Notification, parameters: [NSObject: AnyObject]?) {
        let n = NSNotification(name: notification.rawValue, object: nil, userInfo: parameters)
        NSNotificationCenter.defaultCenter().postNotification(n)
    }
}
