//
//  ProfileEditImageCollectionViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileEditImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: ProfileImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configure(imagePath: String) {
        profileImageView.configure(url: NSURL(string: imagePath), placeholderImage: nil, notRounded: false)
    }
}
