//
//  ProfileImageView.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/09/06.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import Bolts
import SDWebImage

class ProfileImageView: UIImageView {

    // UserDtoを渡した時はメインの画像が設定される
    class func build(userDto: UserDto, rounded: Bool = false) -> ProfileImageView {
        let profileImageView = ProfileImageView()
        profileImageView.configure(url: NSURL(string: userDto.profileImagePath0!), placeholderImage: nil, rounded: rounded)
        return profileImageView
    }

    func configure(url url: NSURL?, placeholderImage: UIImage?, rounded: Bool = false) -> BFTask {
        let completionSource = BFTaskCompletionSource()

        if let u = url {
            sd_setImageWithURL(u, placeholderImage: placeholderImage, options: .RetryFailed, completed: {
                [weak self] ( _, error, _, _ ) -> Void in
                if error != nil {
                    completionSource.setError(error)
                } else {
                    if rounded { self?.round() }
                    completionSource.setResult(true)
                }
            })
        }

        if rounded { self.round() }

        return completionSource.task
    }
}
