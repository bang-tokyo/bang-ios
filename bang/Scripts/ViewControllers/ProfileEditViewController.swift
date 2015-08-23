//
//  ProfileSettingViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

protocol ProfileEditViewControllerDelegate {
    func openBloodTypeSelectorViewController()
    func openRegionSelectorViewController()
    func closeRegionSelectorViewController(regionDto: RegionDto)
}

class ProfileEditViewController: UIViewController {

    class func build(userDto: UserDto) -> (UINavigationController, ProfileEditViewController) {
        var storyboard = UIStoryboard(name: "ProfileEdit", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var profileSettingViewController = navigationViewController.topViewController as! ProfileEditViewController
        profileSettingViewController.userDto = userDto
        return (navigationViewController, profileSettingViewController)
    }

    @IBOutlet weak var tableView: UITableView!

    var userDto: UserDto!
    private var dataHandler: ProfileEditDataHandler!
    private var regionSelectorViewController: RegionSelectorViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = ProfileEditDataHandler()
        dataHandler.setup(tableView, userDto: userDto)
        dataHandler.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideDoneButton(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
}


extension ProfileEditViewController: ProfileEditViewControllerDelegate {
    func openBloodTypeSelectorViewController() {
    }

    func openRegionSelectorViewController() {
        if regionSelectorViewController == nil {
            var (navigationController, viewController) = RegionSelectorViewController.build()
            viewController.delegate = self
            regionSelectorViewController = viewController
        }
        self.navigationController?.pushViewController(regionSelectorViewController!, animated: true)
    }

    func closeRegionSelectorViewController(regionDto: RegionDto) {
        if self.navigationController?.topViewController == regionSelectorViewController {
            self.navigationController?.popViewControllerAnimated(true)
        }
        dataHandler.updateRegionState(regionDto)
    }
}
