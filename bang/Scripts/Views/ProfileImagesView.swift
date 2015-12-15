//
//  ProfileImagesView.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/09/21.
//  Copyright © 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ProfileImagesView: UIView {

    func configure(userDto: UserDto, memberUserDto: [UserDto]?, rounded: Bool = false) {
        if memberUserDto == nil {
            return configureOfOne(userDto)
        } else if memberUserDto!.count == 1 {
            return configureOfTwo(userDto, memberUserDto!.first!)
        } else {
            return configureOfThree(userDto, memberUserDto!)
        }
        if rounded { round() }
    }
}

extension ProfileImagesView {
    private func configureOfOne(userDto: UserDto) {
        let imageView = ProfileImageView.build(userDto)
        imageView.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.addSubview(imageView)
    }

    private func configureOfTwo(userDto: UserDto, _ memberUserDto: UserDto) {
        let width = frame.size.width
        let height = frame.size.height

        let imageView_1 = ProfileImageView.build(userDto)
        let imegeView_2 = ProfileImageView.build(memberUserDto)
        imageView_1.frame = CGRectMake(0, 0, width/2, height)
        imegeView_2.frame = CGRectMake(width/2, 0, width/2, height)

        self.addSubview(imageView_1)
        self.addSubview(imegeView_2)
    }

    private func configureOfThree(userDto: UserDto, _ memberUserDto: [UserDto]) {
        let width = frame.size.width
        let height = frame.size.height

        let imageView_1 = ProfileImageView.build(userDto)
        let imegeView_2 = ProfileImageView.build(memberUserDto[0])
        let imageView_3 = ProfileImageView.build(memberUserDto[1])
        imageView_1.frame = CGRectMake(-(width/4), 0, width, height)
        imegeView_2.frame = CGRectMake(width/2, 0, width/2, height/2)
        imageView_3.frame = CGRectMake(width/2, height/2, width/2, height/2)

        self.addSubview(imageView_1)
        self.addSubview(imegeView_2)
        self.addSubview(imageView_3)
    }
}
