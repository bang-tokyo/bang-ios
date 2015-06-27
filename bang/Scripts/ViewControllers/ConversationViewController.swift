//
//  ConversationViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    class func build() -> ConversationViewController {
        var storyboard = UIStoryboard(name: "Conversation", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        return viewControllers[0] as! ConversationViewController
    }

    @IBOutlet weak var tableView: UITableView!

    private var dataHandler: ConversationDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = ConversationDataHandler()
        dataHandler.setup(tableView)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showDetail:", name: Notification.ConversationDetailWillShow.rawValue, object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
            let conversationId = parameters["conversationId"] as! Int
            var (navigationViewController, conversationDetailViewController) = ConversationDetailViewController.build(conversationId)
            navigationViewController.modalTransitionStyle = .FlipHorizontal
            presentViewController(navigationViewController, animated: true, completion: nil)
        }
    }
}
