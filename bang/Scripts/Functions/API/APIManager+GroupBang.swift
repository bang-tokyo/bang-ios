//
//  APIManager+GroupBang.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/05/30.
//  Copyright (c) 2015年 Tomoyuki Takata. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func requestGroupBang(groupId: Int, fromGroupId: Int) -> BFTask {
        return request(.POST, path: "/v1/group_bang/request", parameters: [
                "group_id": groupId,
                "from_group_id": fromGroupId
            ]).APIErrorHandler()
    }

    func replyGroupBang(groupId: Int, fromGroupId: Int, status: BangStatus) -> BFTask {

        var setStatus:String!

        switch status {
            case .Accept:
                setStatus = "accept"
            case .Deny:
                setStatus = "deny"
            default:
                setStatus = "default"
        }

        return request(.POST, path: "/v1/group_bang/reply", parameters: [
                "group_id": groupId,
                "from_group_id": fromGroupId,
                "status": setStatus
            ]).APIErrorHandler()
    }

    func requestedGroupBangList(fromGroupId: Int) -> BFTask {
        return request(.GET, path: "/v1/group_bang/requests/\(fromGroupId)").APIErrorHandler()
    }
}
