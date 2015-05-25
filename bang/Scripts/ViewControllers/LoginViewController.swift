//
//  LoginViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import Bolts
import Mantle

class LoginViewController: BaseViewController {

    class func build() -> LoginViewController {
        var storyboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateInitialViewController() as! LoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickLoginButton(sender: UIButton) {
        FacebookManager.sharedInstance.authorize().continueWithBlock({
            (task) -> AnyObject! in

            if let facebookUser = APIResponse.parse(APIResponse.Facebook.User.self, task.result) {
                return APIManager.sharedInstance.registerUser(facebookUser.id, name: facebookUser.name, birthday: facebookUser.birthday, gender: facebookUser.gender)
            }

            return BFTask(error: Error.create())
        }).showErrorIfNeeded().continueWithBlock({
            (task) -> AnyObject! in

            if let user = APIResponse.parse(APIResponse.User.self, task.result) {

                DataStore.sharedInstance.saveUser(user)

                if let token = user.token {
                    if let userId = user.id {
                        MyAccount.sharedInstance.login(userId, token: token)
                    }
                } else {
                    BFTask(error: Error.create())
                }

                self.moveToProfileViewController()
            }

            return task
        })
    }

}

// MARK: - Private functions
extension LoginViewController {
    private func moveToProfileViewController() {
        self.moveTo(TabBarViewController())
    }
}
