//
//  ConversationMessageTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/08.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK
import TTTAttributedLabel

let kMessageLayoutVersion: Int = 100000000

class ConversationMessageTableViewCell: UITableViewCell {
    private struct Const {
        static let MinePadding: CGFloat = 5 * 2
        static let OtherPadding: CGFloat = 5 * 2 + 30
        static let VarticalMargin: CGFloat = 5 * 2 + 1
        static let MinHeight: CGFloat = 37.0
    }

    var messageDto: MessageDto? = nil

    @IBOutlet weak var profilePictureView: FBProfilePictureView! // NOTE: - 自分のメッセージにはprofilePictureViewがないので注意
    @IBOutlet weak var messageLabel: AttributedLabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(messageDto: MessageDto) {
        self.messageDto = messageDto
        let padding = ConversationMessageTableViewCell.padding(messageDto)
        messageLabel.configure(messageDto.message, Style.MessageLabel, frame.size.width - padding)
        if (profilePictureView != nil) {
            let user = messageDto.user
            profilePictureView.profileID = user?.facebookId
        }
    }

    class func messageHeightCertainly(messageDto: MessageDto) -> CGFloat {
        return _messageHeight(messageDto)
    }

    class func messageHeight(messageDto: MessageDto) ->CGFloat {
        if (messageDto.layoutVersion!.integerValue == kMessageLayoutVersion
            && messageDto.layoutHeight!.floatValue > 0
        ) {
            return CGFloat(messageDto.layoutHeight!.floatValue)
        }
        return _messageHeight(messageDto)
    }
}

// MARK: - Private functions
extension ConversationMessageTableViewCell {
    private class func padding(messageDto: MessageDto) -> CGFloat {
        return messageDto.isMine() ? Const.MinePadding : Const.OtherPadding
    }

    private class func _messageHeight(messageDto: MessageDto) -> CGFloat {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let width = screenWidth - ConversationMessageTableViewCell.padding(messageDto)

        var messageLabel = AttributedLabel(frame: CGRectMake(0, 0, width, 0))
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.configure(messageDto.message, Style.MessageLabel, width)
        messageLabel.sizeToFit()
        return max(messageLabel.bounds.height+Const.VarticalMargin, Const.MinHeight)
    }
}
