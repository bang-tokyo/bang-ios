//
//  SearchTargetGroupCollectionViewCell.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/05/28.
//  Copyright (c) 2015年 Tomoyuki Takata. All rights reserved.
//

import UIKit
import FacebookSDK

class SearchTargetGroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var profilePictureView: FBProfilePictureView!
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profilePictureView.makeCircle()
    }

    func setup(user: APIResponse.Group) {
        //label.text = user.name
        //profilePictureView.profileID = user.facebookId
    }
}
