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

    var userBangDto: UserBangDto? = nil

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
        self.userBangDto = userBangDto
        profilePictureView.profileID = userBangDto.fromUser?.facebookId
        nameLabel.text = self.userBangDto?.fromUser?.name
    }

    @IBAction func onClickAcceptButton(sender: UIButton) {
        replyBang(BangStatus.Accept)
    }

    @IBAction func onClickDenyButton(sender: UIButton) {
        replyBang(BangStatus.Deny)
    }
}

// MARK: - Private functions
extension RequestedBangTableViewCell {
    private func replyBang(status: BangStatus) {
        if let _userBangDto: UserBangDto = userBangDto {
            APIManager.sharedInstance.replyBang(_userBangDto.id!.integerValue, status: status).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                if let strongSelf = self, userBang = APIResponse.parse(APIResponse.UserBang.self, task.result) {
                    return DataStore.sharedInstance.saveUserBang(userBang)
                }
                return task
            })
        }
    }
}
