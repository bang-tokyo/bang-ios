//
//  ConversationViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    class func build() -> (UINavigationController, ConversationViewController) {
        let tabBarViewController = UIStoryboard(name: "Conversation", bundle: nil).instantiateInitialViewController() as! UITabBarController
        let navigationController = tabBarViewController.viewControllers?.first as! UINavigationController
        let viewController = navigationController.topViewController as! ConversationViewController
        return (navigationController, viewController)
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
            let (_, viewController) = ConversationDetailViewController.build(conversationId)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
