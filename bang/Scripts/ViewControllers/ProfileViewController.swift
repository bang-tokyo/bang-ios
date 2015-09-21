//
//  ProfileViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    class func build(userDto: UserDto) -> (UINavigationController, ProfileViewController) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let profileViewController = navigationViewController.topViewController as! ProfileViewController
        profileViewController.userDto = userDto
        return (navigationViewController, profileViewController)
    }

    @IBOutlet weak var editButton: UIBarButtonItem!

    var userDto: UserDto!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !userDto.isMine() {
            navigationItem.setRightBarButtonItem(nil, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideEditbutton(sender: UIBarButtonItem) {
        if userDto.isMine() {
            let (_, viewController) = ProfileEditViewController.build(userDto)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
