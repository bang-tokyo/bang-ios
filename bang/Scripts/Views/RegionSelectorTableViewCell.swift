//
//  RegionSelectorTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class RegionSelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    var regionDto: RegionDto? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(regionDto: RegionDto) {
        self.regionDto = regionDto
        nameLabel.text = regionDto.name
    }
}
