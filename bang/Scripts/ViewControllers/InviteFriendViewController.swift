//
//  InviteFriendViewController.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/02/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

protocol InviteFriendViewControllerDelegate {
    func invitedFriend(user: APIResponse.Facebook.FriendUser)->Void
}

class InviteFriendViewController: UIViewController, InviteFriendViewControllerDelegate {

    class func build() -> InviteFriendViewController {
        let storyboard = UIStoryboard(name: "InviteFriend", bundle: nil)
        return storyboard.instantiateInitialViewController() as! InviteFriendViewController
    }

    @IBOutlet weak var tableView: UITableView!

    var friendUsers: [APIResponse.Facebook.FriendUser]!
    var delegate: facebookFriendDelegate!

    private var dataHandler: InviteFriendDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandler = InviteFriendDataHandler()
        dataHandler.delegate = self
        dataHandler.setup(tableView,users: friendUsers)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func invitedFriend(user: APIResponse.Facebook.FriendUser) {
        delegate.invitedFriend(user)
        closeViewController()
    }

    @IBAction func onTouchUpInsideCloseBtn(sender: UIBarButtonItem) {
        self.closeViewController()
    }
}
