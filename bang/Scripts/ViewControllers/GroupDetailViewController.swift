//
//  GroupDetailViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class GroupDetailViewController: UIViewController {

    class func build(groupId: Int) -> (UINavigationController, GroupDetailViewController) {
        let storyboard = UIStoryboard(name: "GroupDetail", bundle: nil)
        let navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let groupDetailViewController = navigationViewController.topViewController as! GroupDetailViewController
        return (navigationViewController, groupDetailViewController)
    }

    @IBOutlet weak var groupOwnerPictureView: GroupMemberImageView!
    @IBOutlet weak var groupMember1PictureView: GroupMemberImageView!
    @IBOutlet weak var groupMember2PictureView: GroupMemberImageView!


    var groupId: Int!
    private weak var groupDto: GroupDto!

    private var dataHandler: GroupDetailDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataHandler = GroupDetailDataHandler()
        dataHandler.setup(groupId)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showGroupInfo:", name: Notification.GroupDetailInfoWillShow.rawValue, object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        dataHandler.fetchData()
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showGroupInfo(notification: NSNotification) {
        if let parameters = notification.userInfo {
            let group = parameters["group"] as! APIResponse.Group

            //グループ名セット
            self.navigationItem.title = group.name

            //メンバー画像セット
            let groupUsers: [APIResponse.GroupUser] = group.groupUsers
            let groupUsersNum: Int = groupUsers.count

            //オーナー
            self.groupOwnerPictureView.setup((groupUsers.filter {
                $0.ownerFlg == 1
            }.first?.facebookId)!)

            if groupUsersNum >= 2 {
                self.groupMember1PictureView.setup(groupUsers[1].facebookId)
                self.groupMember2PictureView.setup(groupUsers[2].facebookId)
            } else {
                self.groupMember1PictureView.setup(groupUsers[1].facebookId)
            }
        }
    }
}
