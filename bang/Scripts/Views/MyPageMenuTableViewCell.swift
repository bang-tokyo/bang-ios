//
//  MyPageMenuTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class MyPageMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
