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
    var myPageViewController: MyPageViewController!
    var searchViewController: UIViewController!
    var conversationViewController: ConversationViewController!
    var requestedBangViewController: RequestedBangViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPageViewController = MyPageViewController.build()
        searchViewController = UIViewController()
        conversationViewController = ConversationViewController.build()
        requestedBangViewController = RequestedBangViewController.build()

        super.viewDidLoad()

        // TODO: - Designがきまったら修正
        myPageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 0)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Contacts, tag: 0)
        conversationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Favorites, tag: 0)
        requestedBangViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .History, tag: 0)


        self.setViewControllers([conversationViewController, requestedBangViewController, searchViewController, myPageViewController], animated: false)
        self.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController != self.searchViewController) { return true }
        //let searchViewController = ShortSearchViewController.build()
        let searchViewController = MiddleSearchViewController.build()
        self.presentViewController(searchViewController, animated: true, completion: nil)
        return false
    }
}
