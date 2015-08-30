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

    func resizeAspectFit(size: CGSize) -> UIImage {
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
        return resize(ratio)
    }

    private func resize(ratio: CGFloat) -> UIImage {
        let resizedSize = CGSizeMake(size.width * ratio, size.height * ratio)

        UIGraphicsBeginImageContext(resizedSize)
        drawInRect(CGRectMake(0, 0, resizedSize.width, resizedSize.height))
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
