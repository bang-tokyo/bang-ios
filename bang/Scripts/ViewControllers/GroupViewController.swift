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
        var storyboard = UIStoryboard(name: "Group", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        var navigationController = viewControllers[0] as! UINavigationController
        var viewController = navigationController.topViewController as! GroupViewController
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
        //NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showDetail(notification: NSNotification) {
        if let parameters = notification.userInfo {
            let groupId = parameters["groupId"] as! Int
            var (navigationController, viewController) = GroupDetailViewController.build(groupId)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
