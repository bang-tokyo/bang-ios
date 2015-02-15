//
//  LoginViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    class func build() -> LoginViewController {
        var storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateInitialViewController() as LoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        FacebookManager.sharedInstance.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickLoginButton(sender: UIButton) {
        FacebookManager.sharedInstance.openFacebookSession()
    }

}

// MARK: - FacebookManagerDelegate
extension LoginViewController: FacebookManagerDelegate {
    func handlerFacebookSessionStateChanged(isLogined: Bool) {
        if isLogined {
            var viewController = ProfileViewController.build()
            self.moveTo(viewController)
        }
    }
}

// MARK: - Private functions
extension LoginViewController {
}
