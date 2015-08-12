//
//  MyPageProfileTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class MyPageProfileTableViewCell: UITableViewCell {

    var userDto: UserDto?
    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profilePictureView.makeCircle()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(userDto: UserDto) {
        self.userDto = userDto
        profilePictureView.profileID = userDto.facebookId
        nameLabel.text = userDto.name
    }
}
