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

    func configure(url url: NSURL?, placeholderImage: UIImage?, notRounded: Bool = true) -> BFTask {
        let completionSource = BFTaskCompletionSource()

        if let u = url {
            sd_setImageWithURL(u, placeholderImage: placeholderImage, options: .RetryFailed, completed: {
                [weak self] ( _, error, _, _ ) -> Void in
                if error != nil {
                    completionSource.setError(error)
                } else {
                    if notRounded { self?.round() }
                    completionSource.setResult(true)
                }
            })
        }

        if notRounded { self.round() }

        return completionSource.task
    }
}

extension ProfileImageView {
    private func round() {
        layer.cornerRadius = frame.size.width * 0.5
        layer.masksToBounds = true
    }
}
