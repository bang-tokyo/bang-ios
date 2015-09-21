//
//  UIViewExtension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

extension UIView {

    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func makeCircle() {
        self.layer.cornerRadius = self.bounds.width / 2.0
        self.clipsToBounds = true
    }

    func setBlurBackground(view: UIView) {
        let image:UIImage = view.convertToImage()
        image.applyBlurWithRadius()
        self.backgroundColor = UIColor(patternImage: image)
    }

    func addSubviewOnCenter(view: UIView) {
        view.frame = self.centerFrameInUIView(view)
        self.addSubview(view)
    }

    func addImageviewOnCenterByName(name: String) -> UIImageView {
        let image: UIImage = UIImage(named: name)!
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width*0.60,
            height: self.bounds.height*0.60
        ))
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubviewOnCenter(imageView)
        return imageView
    }

    func addSubViewToFix(childView:UIView) {
        self.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        let layoutTop = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0
        )
        let layoutBottom = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        let layoutLeft = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1.0,
            constant: 0.0
        )
        let layoutRight = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: 0.0
        )
        let layoutConstraints: [NSLayoutConstraint] = [
            layoutTop, layoutBottom, layoutLeft, layoutRight
        ]
        self.addConstraints(layoutConstraints)
        self.layoutIfNeeded()
    }

    func centerFrameInUIView(view: UIView) -> CGRect {
        let width: CGFloat = view.frame.size.width
        let height: CGFloat = view.frame.size.height
        let marginX: CGFloat = self.frame.size.width - width
        let marginY: CGFloat = self.frame.size.height - height
        return CGRectMake(marginX/2.0, marginY/2.0, width, height)
    }

}
