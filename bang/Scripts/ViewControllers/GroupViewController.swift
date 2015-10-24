//
//  GroupViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/08/29.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    class func build() -> (UINavigationController, GroupViewController) {
        let storyboard = UIStoryboard(name: "Group", bundle: nil)
        let tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        let navigationController = tabBarViewController.viewControllers?.first as! UINavigationController
        let viewController = navigationController.topViewController as! GroupViewController
        return (navigationController, viewController)
    }

    @IBOutlet weak var tableView: UITableView!

    private var dataHandler: GroupDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = GroupDataHandler()
        dataHandler.setup(tableView)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showDetail:", name: Notification.GroupDetailWillShow.rawValue, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dataHandler.fetchData()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideGroupCreateBtn(sender: UIButton) {
        let (_, viewController) = CreateGroupViewController.build()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func showDetail(notification: NSNotification) {
        if let parameters = notification.userInfo {
            let groupId = parameters["groupId"] as! Int
            let (_, viewController) = GroupDetailViewController.build(groupId)
            viewController.groupId = groupId
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
