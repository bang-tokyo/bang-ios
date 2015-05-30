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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
