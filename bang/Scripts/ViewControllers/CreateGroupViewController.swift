//
//  CreateGroupViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

protocol facebookFriendDelegate {
    func invitedFriend(user: APIResponse.Facebook.FriendUser)->Void
    func cancelInviteFriend(user: APIResponse.Facebook.FriendUser)->Void
}

class CreateGroupViewController: UIViewController, facebookFriendDelegate {

    class func build() -> (UINavigationController, CreateGroupViewController) {
        let storyboard = UIStoryboard(name: "CreateGroup", bundle: nil)
        let navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let createGroupViewController = navigationViewController.topViewController as! CreateGroupViewController
        return (navigationViewController, createGroupViewController)
    }

    //招待する友達
    var inviteUsers: [APIResponse.Facebook.FriendUser]! = []

    var userDto: UserDto?
    @IBOutlet weak var groupOwnerPictureView: GroupMemberImageView!
    @IBOutlet weak var groupMember1PictureView: GroupMemberImageView!
    @IBOutlet weak var groupMember2PictureView: GroupMemberImageView!

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var createGroupBtn: UIButton!

    @IBAction func onTouchUpInsideCreateGroupBtn(sender: UIButton) {
        //TODO: グループ名が空ならエラー

        //TODO: 実値入れる
        let name: String = self.groupNameTextField.text!
        let memo: String = ""
        let regionId :Int = 1

        var groupId: Int!
        var groupName: String!

        APIManager.sharedInstance.createGroup(name, memo: memo, regionId: regionId).continueWithBlock({
            [weak self] (task) -> AnyObject! in
                if let _ = self, group = APIResponse.parse(APIResponse.Group.self, task.result) {
                    groupId = group.id as Int
                    groupName = group.name
                }
                return task
        }).continueWithBlock({
            [weak self] (task) -> AnyObject! in
                for user in (self?.inviteUsers)! {
                    APIManager.sharedInstance.inviteGroupMember(user.id,groupId: groupId).continueWithBlock({
                        (task) -> AnyObject! in
                        return task
                    })
                }

                Alert.showNormal("CreateGroup", message: "Success to create \(groupName)")
                return task
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = UserDto.firstById(MyAccount.sharedInstance.userId) as? UserDto {
            userDto = user
        } else {
            //TODO: error処理
        }

        self.groupNameTextField.delegate = self

        self.groupOwnerPictureView.setup(userDto!.facebookId!)

        self.groupNameTextField.placeholder = "グループ名を入力してください"

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
        setInvitedFriend(user.id)
        self.inviteUsers.append(user)
    }

    func cancelInviteFriend(user: APIResponse.Facebook.FriendUser) {

    }

}

extension CreateGroupViewController :UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        return true
    }
}

// MARK: - Private functions
extension CreateGroupViewController {
    private func setInvitedFriend(facebookId: String) {
        if groupMember1PictureView.fBProfilePictureView.hidden {
            groupMember1PictureView.setup(facebookId,isInvited: true)
        } else {
            groupMember2PictureView.setup(facebookId,isInvited: true)
        }
    }
}
