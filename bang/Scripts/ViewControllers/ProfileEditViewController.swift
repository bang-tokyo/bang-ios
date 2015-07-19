//
//  ProfileSettingViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {

    class func build(userDto: UserDto) -> (UINavigationController, ProfileEditViewController) {
        var storyboard = UIStoryboard(name: "ProfileEdit", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var profileSettingViewController = navigationViewController.topViewController as! ProfileEditViewController
        profileSettingViewController.userDto = userDto
        return (navigationViewController, profileSettingViewController)
    }

    var userDto: UserDto!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideDoneButton(sender: UIBarButtonItem) {
        println("--> OK")
        navigationController?.popViewControllerAnimated(true)
    }
}
