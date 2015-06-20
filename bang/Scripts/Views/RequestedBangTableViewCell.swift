//
//  RequestedBangTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/01.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class RequestedBangTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(userBangDto: UserBangDto) {
        profilePictureView.profileID = userBangDto.fromUser?.facebookId
        nameLabel.text = userBangDto.fromUser?.name
    }

    @IBAction func onClickAcceptButton(sender: UIButton) {
    }

    @IBAction func onClickDenyButton(sender: UIButton) {
    }
}
