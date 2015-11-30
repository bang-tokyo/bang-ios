//
//  InviteFriendTableViewCell.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/08.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class InviteFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var fbProfilePictureView: FBProfilePictureView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var inviteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(facebookId:String,name:String) {
        fbProfilePictureView.profileID = facebookId
        nameLabel.text = name
    }
}
