//
//  UIImageExtension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

extension UIImage {
    func applyBlurWithRadius() {
        self.applyBlurWithRadius(
            10,
            tintColor: UIColor(white: 0.11, alpha: 0.73),
            saturationDeltaFactor:1.3,
            maskImage: nil
        )
    }
}