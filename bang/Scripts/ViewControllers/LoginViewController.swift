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

        var loginView: FBLoginView = FBLoginView(readPermissions: FBReadPermissions)
        loginView.center = self.view.center
        self.view.addSubview(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickLoginButton(sender: UIButton) {
        FacebookManager.sharedInstance.openFacebookSession()
//        var viewController = SearchViewController.build()
//        self.moveTo(viewController)
    }

}

extension LoginViewController: FBLoginViewDelegate {
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("--> \(user.name)")
    }
}
