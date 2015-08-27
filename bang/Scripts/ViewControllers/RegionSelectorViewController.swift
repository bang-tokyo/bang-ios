//
//  RegionSelectorViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

protocol RegionSelectorViewControllerDelegate {
    func didSelectRegion(regionDto: RegionDto)
}

class RegionSelectorViewController: UIViewController {

    class func build() -> (UINavigationController, RegionSelectorViewController) {
        var storyboard = UIStoryboard(name: "RegionSelector", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var regionSelectorViewController = navigationViewController.topViewController as! RegionSelectorViewController
        return (navigationViewController, regionSelectorViewController)
    }

    @IBOutlet weak var tableView: UITableView!

    var delegate: ProfileEditViewControllerDelegate!
    var dataHandler: RegionSelectorDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataHandler = RegionSelectorDataHandler()
        dataHandler.delegate = self
        dataHandler.setup(tableView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataHandler.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RegionSelectorViewController: RegionSelectorViewControllerDelegate {
    func didSelectRegion(regionDto: RegionDto) {
        delegate.closeRegionSelectorViewController(regionDto)
    }
}
