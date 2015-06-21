//
//  RequestedBangViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/01.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class RequestedBangViewController: UIViewController {

    class func build() -> RequestedBangViewController {
        var storyboard = UIStoryboard(name: "RequestedBang", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        return viewControllers[0] as! RequestedBangViewController
    }

    @IBOutlet weak var tableView: UITableView!

    private var dataHandler: RequestedBangDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = RequestedBangDataHandler()
        dataHandler.setup(tableView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dataHandler.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
