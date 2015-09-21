//
//  GroupDetailViewController.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class GroupDetailViewController: UIViewController {

    class func build(groupId: Int) -> (UINavigationController, GroupDetailViewController) {
        let storyboard = UIStoryboard(name: "GroupDetail", bundle: nil)
        let navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let groupDetailViewController = navigationViewController.topViewController as! GroupDetailViewController
        return (navigationViewController, groupDetailViewController)
    }

    var groupId: Int!

    private var dataHandler: GroupDetailDataHandler!

    private weak var groupDto: GroupDto!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataHandler = GroupDetailDataHandler()
        dataHandler.setup(groupId)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataHandler.fetchData()
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
