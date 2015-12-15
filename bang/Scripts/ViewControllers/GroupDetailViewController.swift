//
//  GroupDetailViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class GroupDetailViewController: UIViewController, facebookFriendDelegate {

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
        dataHandler.fetchData()
        self.showGroupInfo()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "asyncGroupInfo:", name: Notification.GroupDetailInfoWillShow.rawValue, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showFacebookFriends:", name: Notification.FacebookFriendWillShow.rawValue, object: nil)
    }

    override func viewWillAppear(animated: Bool) {
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

    func showGroupInfo() {
        if let group = GroupDto.firstById(self.groupId) as? GroupDto {
            groupDto = group

            //グループ名セット
            self.navigationItem.title = groupDto.name

            let groupUsers: [GroupUserDto]? = groupDto.getGroupUsers(self.groupId)

            //オーナー画像表示
            self.groupOwnerPictureView.setup((groupUsers!.filter {
                    $0.ownerFlg == 1
                }.first?.facebookId)!)
        }
    }

    //詳細を表示するタイミングでbackgroundで詳細情報を取得し、最新の情報と同期させる
    func asyncGroupInfo(notification: NSNotification) {
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

            var isInvited: Bool!
            for(var i = 1;i < groupUsersNum;i++) {
                //statusが2なら招待中を表示
                isInvited = groupUsers[i].statusValue == 2
                if (i == 1) {
                    self.groupMember1PictureView.setup(groupUsers[i].facebookId, isInvited: isInvited)
                }else if(i == 2) {
                    self.groupMember2PictureView.setup(groupUsers[i].facebookId, isInvited: isInvited)
                }
            }
        }
    }

    func showFacebookFriends(notification: NSNotification) {
        if let parameters = notification.userInfo {
            let friendUsers = parameters["facebookFriends"] as! [APIResponse.Facebook.FriendUser]

            if friendUsers.count <= 0 { return }

            let inviteFriendViewController = InviteFriendViewController.build()
            inviteFriendViewController.friendUsers = friendUsers
            inviteFriendViewController.delegate = self
            self.presentViewController(inviteFriendViewController, animated: true, completion: nil)
        }
    }

    func invitedFriend(user: APIResponse.Facebook.FriendUser) {
        APIManager.sharedInstance.inviteGroupMember(user.id,groupId: groupId).continueWithBlock({
            [weak self] (task) -> AnyObject! in
                self!.setInvitedFriend(user.id)
                return task
        })
    }

    func cancelInviteFriend(user: APIResponse.Facebook.FriendUser) {

    }
}

// MARK: - Private functions
extension GroupDetailViewController {
    private func setInvitedFriend(facebookId: String) {
        if groupMember1PictureView.fBProfilePictureView.hidden {
            groupMember1PictureView.setup(facebookId,isInvited: true)
        } else {
            groupMember2PictureView.setup(facebookId,isInvited: true)
        }
    }
}
