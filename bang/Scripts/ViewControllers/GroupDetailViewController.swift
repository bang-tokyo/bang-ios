//
//  GroupDetailViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class GroupDetailViewController: UIViewController {

    class func build(conversationId: Int) -> (UINavigationController, GroupDetailViewController) {
        var storyboard = UIStoryboard(name: "GroupDetail", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var groupDetailViewController = navigationViewController.topViewController as! GroupDetailViewController
        return (navigationViewController, groupDetailViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
