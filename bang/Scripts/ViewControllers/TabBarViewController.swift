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
    var profileViewController: ProfileViewController!
    var searchViewController: UIViewController!
    var conversationViewController: ConversationViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileViewController = ProfileViewController.build()
        searchViewController = UIViewController()
        conversationViewController = ConversationViewController.build()

        super.viewDidLoad()

        // TODO: - Designがきまったら修正
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 0)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 0)
        conversationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 0)


        self.setViewControllers([profileViewController, searchViewController, conversationViewController], animated: false)
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
