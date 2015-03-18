//
//  ProfileViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/15.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    class func build() -> ProfileViewController {
        var storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateInitialViewController() as ProfileViewController
    }

    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var nameLabel: UILabel!

    var facebookManager: FacebookManager = FacebookManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        facebookManager.requestUserData({
            [unowned self] (userData: NSDictionary) in
            self.nameLabel.text = userData.objectForKey("name") as? String
            self.profilePictureView.profileID = userData.objectForKey("id") as String
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profilePictureView.makeCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickSearchButton(sender: UIBarButtonItem) {
        var searchViewController = SearchViewController.build()
        searchViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(searchViewController)
    }

    @IBAction func onClickLogoutButton(sender: UIButton) {
        FacebookManager.sharedInstance.closeFacebookSession()
    }
}