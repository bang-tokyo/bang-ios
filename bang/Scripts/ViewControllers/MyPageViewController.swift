//
//  MyPageViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/15.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

protocol MyPageViewControllerDelegate {
    func openProfileViewController()
    func logout()
}

class MyPageViewController: UIViewController {

    class func build() -> (UINavigationController, MyPageViewController) {
        var storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        var navigationController = viewControllers[0] as! UINavigationController
        var viewController = navigationController.topViewController as! MyPageViewController
        return (navigationController, viewController)
    }

    @IBOutlet weak var tableView: UITableView!

    var userDto: UserDto?
    private var dataHandler: MyPageDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = MyPageDataHandler()
        dataHandler.delegate = self
        if let user = UserDto.firstById(MyAccount.sharedInstance.userId) as? UserDto {
            userDto = user
            dataHandler.setup(tableView, userDto: user)
        } else {
            // TODO: - ここにこないはずだけど一応とっておく。あとで整理
            APIManager.sharedInstance.showUser(Int(MyAccount.sharedInstance.userId)).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                if let user = APIResponse.parse(APIResponse.User.self, task.result) {
                    return DataStore.sharedInstance.saveUser(user)
                }
                return task
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Private functions
extension MyPageViewController {
    private func moveToLoginViewController() {
        var loginViewController = LoginViewController.build()
        moveTo(loginViewController)
    }
}

extension MyPageViewController: MyPageViewControllerDelegate {
    func openProfileViewController() {
        if let userDto = self.userDto {
            var (navigationController, viewController) = ProfileViewController.build(userDto)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func logout() {
        DataStore.sharedInstance.deleteAll()
        MyAccount.sharedInstance.logout()
        moveToLoginViewController()
    }
}
