//
//  RequestedBangViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/01.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class RequestedBangViewController: UIViewController {

    class func build() -> (UINavigationController, RequestedBangViewController) {
        let tabBarViewController = UIStoryboard(name: "RequestedBang", bundle: nil).instantiateInitialViewController() as! UITabBarController
        let navigationController = tabBarViewController.viewControllers?.first as! UINavigationController
        let viewController = navigationController.topViewController as! RequestedBangViewController
        return (navigationController, viewController)
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
