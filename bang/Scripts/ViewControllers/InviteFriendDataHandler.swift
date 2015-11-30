//
//  InviteFriendDataHandler.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/06/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

class InviteFriendDataHandler: NSObject {

    private weak var tableView: UITableView!

    private var friendUsers: [APIResponse.Facebook.FriendUser]!

    var delegate: InviteFriendViewControllerDelegate!

    func setup(tableView: UITableView, users: [APIResponse.Facebook.FriendUser]) {
        self.tableView = tableView
        self.tableView.dataSource = self
        self.friendUsers = users
    }

    func loadData() {
        tableView.reloadData()
    }

    func onTouchUpInsideInviteBtn(sender: UIButton, event: UIEvent) {
        let indexPath = self.indexPathForControlEvent(event)
        let user = friendUsers[indexPath.row]
        delegate.invitedFriend(user)
    }
}

// MARK: - UITableViewDataSource
extension InviteFriendDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendUsers.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteFriendCell") as! InviteFriendTableViewCell
        cell.inviteBtn.addTarget(self, action: "onTouchUpInsideInviteBtn:event:", forControlEvents: .TouchUpInside)
        let data: APIResponse.Facebook.FriendUser! = friendUsers[indexPath.row]
        cell.configure(data.id, name: data.name)
        return cell
    }
}

// MARK: - Private functions
extension InviteFriendDataHandler {
    private func indexPathForControlEvent(event: UIEvent) -> NSIndexPath {
        let touch = (event.allTouches()?.first)! as UITouch
        let point = touch.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)
        return indexPath!
    }
}

