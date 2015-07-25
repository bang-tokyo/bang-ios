//
//  TabBarViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var menueWindow = UIWindow()
    var myPageNavigationController: UINavigationController!
    var conversationNavigationController: UINavigationController!
    var requestedBangNavigationController: UINavigationController!
    var searchViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var (myPageNavigationController, myPageViewController) = MyPageViewController.build()
        var (conversationNavigationController, conversationViewController) = ConversationViewController.build()
        var (requestedBangNavigationController, requestedBangViewController) = RequestedBangViewController.build()
        searchViewController = UIViewController()

        self.myPageNavigationController = myPageNavigationController
        self.conversationNavigationController = conversationNavigationController
        self.requestedBangNavigationController = requestedBangNavigationController

        super.viewDidLoad()

        // TODO: - Designがきまったら修正
        myPageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 0)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Contacts, tag: 0)
        conversationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Favorites, tag: 0)
        requestedBangViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .History, tag: 0)

        self.setViewControllers([
            conversationNavigationController,
            requestedBangNavigationController,
            searchViewController,
            myPageNavigationController
        ], animated: false)

        self.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController != self.searchViewController) { return true }
        //let searchViewController = ShortSearchViewController.build()
        let searchViewController = UserMiddleSearchViewController.build()
        self.presentViewController(searchViewController, animated: true, completion: nil)
        return false
    }
}
