//
//  GroupTableViewCell.swift
//  bang
//
//  Created by takatatomoyuki on 2015/09/08.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class GroupTableViewCell: UITableViewCell {

    var groupDto: GroupDto? = nil

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

    func configure(groupDto: GroupDto) {
        self.groupDto = groupDto
        //profilePictureView.profileID = groupDto.fromUser?.facebookId
        nameLabel.text = self.groupDto?.name
    }
}
