//
//  CreateGroupViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {

    class func build() -> (UINavigationController, CreateGroupViewController) {
        let storyboard = UIStoryboard(name: "CreateGroup", bundle: nil)
        let navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let createGroupViewController = navigationViewController.topViewController as! CreateGroupViewController
        return (navigationViewController, createGroupViewController)
    }

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

        APIManager.sharedInstance.createGroup(name, memo: memo, regionId: regionId).continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let _ = self, group = APIResponse.parse(APIResponse.Group.self, task.result) {
                Alert.showNormal("CreateGroup", message: "Success to create \(group.name)")
            }
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

        //作成ボタンのdefaultはdisable
        //self.createGroupBtn.enabled = false

        self.groupNameTextField.placeholder = "グループ名を入力してください"
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
