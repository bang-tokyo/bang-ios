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
    }

    func configure(facebookId: String) {
        if facebookId.isEmpty {
            //TODO: 友達追加用の画像をセットし、押下でfacebookの友達招待に遷移

        } else {
            fBProfilePictureView.profileID = facebookId
            fBProfilePictureView.hidden = false
        }
    }
}
