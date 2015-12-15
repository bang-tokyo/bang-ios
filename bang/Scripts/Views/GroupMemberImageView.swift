//
//  GroupMemberImageView.swift
//  bang
//
//  Created by takatatomoyuki on 2015/10/14.
//  Copyright © 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class GroupMemberImageView: UIView {

    var fBProfilePictureView: FBProfilePictureView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.makeCircle()

        fBProfilePictureView = FBProfilePictureView(frame: CGRectMake(0, 0, 159, 159))
        fBProfilePictureView.layer.position = CGPointMake(
            self.bounds.maxX - fBProfilePictureView.bounds.midX,
            self.bounds.maxY - fBProfilePictureView.bounds.midY
        )
        fBProfilePictureView.hidden = true
        self.addSubview(fBProfilePictureView)

        let tap = UITapGestureRecognizer(target: self, action: "onTapFriendInvite")
        self.addGestureRecognizer(tap)
    }

    func setup(facebookId: String, isInvited: Bool = false) {
        fBProfilePictureView.profileID = facebookId
        fBProfilePictureView.hidden = false

        if isInvited {
            //後日デザイン調整
            let inviteLabel = UILabel(frame: CGRectMake(0, 0, 200, 40));
            inviteLabel.text = "招待中";
            inviteLabel.center = CGPointMake(80, 80);//表示位置
            inviteLabel.textAlignment = NSTextAlignment.Center//整列
            inviteLabel.font = UIFont.systemFontOfSize(16);//文字サイズ
            inviteLabel.textColor = UIColor.whiteColor();//文字色
            inviteLabel.backgroundColor = UIColor.blackColor();//背景色
            self.addSubview(inviteLabel);
        }
    }

    func onTapFriendInvite() {
        if !fBProfilePictureView.hidden { return }

        FacebookManager.sharedInstance.requestUserFriends().continueWithBlock({
            (task) -> AnyObject! in
            if let facebookFriends = APIResponse.parseJSONArray(APIResponse.Facebook.FriendUser.self, task.result.data) {
                NotificationManager.notifyFacebookFriendWillShow(facebookFriends)
            }

            return BFTask(error: Error.create())
        })
    }

}
