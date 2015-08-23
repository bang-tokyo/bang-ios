//
//  ProfileEditChoicesTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/09.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileEditChoicesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    var id: Int!
    var name: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(title: String, id: Int, name: String) {
        titleLabel.text = title
        updateState(id, name: name)
    }

    func updateState(id: Int, name: String) {
        valueLabel.text = name
        self.id = id
        self.name = name
    }
}
