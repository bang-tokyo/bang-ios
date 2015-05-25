//
//  ContactViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    class func build() -> ContactViewController {
        var storyboard = UIStoryboard(name: "Contact", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        return viewControllers[0] as! ContactViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIManager.sharedInstance.showUser(1).continueWithBlock{
            (task) -> AnyObject in
            Tracker.sharedInstance.debug("\(task.result)")
            return task
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
