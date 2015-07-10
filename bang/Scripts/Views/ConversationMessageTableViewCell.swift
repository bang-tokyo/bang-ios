//
//  ConversationMessageTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/08.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import FacebookSDK
import SECoreTextView

let kMessageLineHeight: CGFloat = 5.0
let kMessageFont = UIFont.boldSystemFontOfSize(15)
let kMessageLayoutVersion: Int = 100000000

class ConversationMessageTableViewCell: UITableViewCell {

    var messageDto: MessageDto? = nil

    @IBOutlet weak var profilePictureView: FBProfilePictureView! // NOTE: - 自分のメッセージにはprofilePictureViewがないので注意
    @IBOutlet weak var messageTextView: AttributedTextView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // TODO: - Designきまったら要修正
        //messageTextView.lineHeight = kMessageLineHeight
        messageTextView.delegate = self
        messageTextView.font = kMessageFont
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(messageDto: MessageDto) {
        self.messageDto = messageDto
        messageTextView.text = messageDto.message
        if (profilePictureView != nil) {
            let user = messageDto.user
            profilePictureView.profileID = user?.facebookId
        }
    }

    class func messageSizeCertainly(messageDto: MessageDto) -> CGSize {
        return _messageSize(messageDto)
    }

    class func messageSize(messageDto: MessageDto) ->CGSize {
        if (messageDto.layoutVersion!.integerValue == kMessageLayoutVersion
            && messageDto.layoutWidth!.floatValue > 0
            && messageDto.layoutHeight!.floatValue > 0
        ) {
            return CGSizeMake(CGFloat(messageDto.layoutWidth!.floatValue), CGFloat(messageDto.layoutHeight!.floatValue))
        }
        return _messageSize(messageDto)
    }
}

// MARK: - Private functions
extension ConversationMessageTableViewCell {
    private class func _messageSize(messageDto: MessageDto) -> CGSize {
        var screenWidth = UIScreen.mainScreen().bounds.width
        var horizontalMargin: CGFloat = messageDto.isMine() ? 5 * 2 : 5 * 2 + 30
        var varticalMargin: CGFloat = 5 * 2

        var attributedString = NSAttributedString(string: messageDto.message!)
        var messageFrameRect = SETextView.frameRectWithAttributtedString(attributedString, constraintSize: CGSizeMake(screenWidth - horizontalMargin, 1000), lineSpacing: kMessageLineHeight, font: kMessageFont)

        return CGSizeMake(messageFrameRect.size.width, messageFrameRect.size.height + varticalMargin)
    }
}

// MARK: - SETextViewDelegate
extension ConversationMessageTableViewCell: SETextViewDelegate {
    func textView(textView: SETextView!, clickedOnLink link: SELinkText!, atIndex charIndex: UInt) -> Bool {
        // TODO: - リンクくらいハンドリングするよな...
        return true
    }
}
