//
//  MyPageViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/15.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class MyPageViewController: UIViewController {

    class func build() -> (UINavigationController, MyPageViewController) {
        var storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        var navigationController = viewControllers[0] as! UINavigationController
        var viewController = navigationController.topViewController as! MyPageViewController
        return (navigationController, viewController)
    }

    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var nameLabel: UILabel!

    var userDto: UserDto?
    var facebookManager: FacebookManager = FacebookManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = UserDto.firstById(MyAccount.sharedInstance.userId) as? UserDto {
            userDto = user
            nameLabel.text = user.name
            profilePictureView.profileID = user.facebookId
        } else {
            APIManager.sharedInstance.showUser(Int(MyAccount.sharedInstance.userId)).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                if let user = APIResponse.parse(APIResponse.User.self, task.result) {
                    self?.nameLabel.text = user.name
                    self?.profilePictureView.profileID = user.facebookId
                    return DataStore.sharedInstance.saveUser(user)
                }
                return task
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePictureView.makeCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onTouchUpInsideProfileBotton(sender: UIButton) {
        if let userDto = self.userDto {
            var (navigationController, viewController) = ProfileViewController.build(userDto)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @IBAction func onTouchUpInsidetButton(sender: UIButton) {
        DataStore.sharedInstance.deleteAll()
        MyAccount.sharedInstance.logout()
        moveToLoginViewController()
    }
}

// MARK: - Private functions
extension MyPageViewController {
    private func moveToLoginViewController() {
        var loginViewController = LoginViewController.build()
        moveTo(loginViewController)
    }
}
