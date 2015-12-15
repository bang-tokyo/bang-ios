//
//  GroupDetailDataHandler.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class GroupDetailDataHandler: NSObject {

    private var groupId: Int!

    var groupList: [APIResponse.Group]?

    func setup(groupId: Int) {
        self.groupId = groupId
    }

    func fetchData() {
        APIManager.sharedInstance.requestGroupInfo(groupId).continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let _ = self, groupList = APIResponse.parseJSONArray(APIResponse.Group.self, task.result) {
                NotificationManager.notifyGroupDetailInfoWillShow(groupList[0])
                return DataStore.sharedInstance.saveGroupList(groupList)
            }
            return task
            })
    }
}
