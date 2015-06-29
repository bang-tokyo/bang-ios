//
//  ConversationTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK

class ConversationTableViewCell: UITableViewCell {

    var conversationDto: ConversationDto? = nil
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

    func configure(conversationDto: ConversationDto) {
        self.conversationDto = conversationDto
        let user = conversationDto.partnerUsers().first
        profilePictureView.profileID = user?.facebookId
        nameLabel.text = user?.name
    }
}
