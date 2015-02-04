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
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func setBlurBackground(parentView: UIView) {
        var image:UIImage = parentView.convertToImage()
        image.applyBlurWithRadius()
        self.backgroundColor = UIColor(patternImage: image)
    }

    func addSubviewOnCenter(view: UIView) {
        view.frame = self.centerFrameInUIView(view)
        self.addSubview(view)
    }

    func addImageviewOnCenterByName(name: String) -> UIImageView {
        var image: UIImage = UIImage(named: name)!
        var imageView = UIImageView(frame: CGRect(
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
        childView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var layoutTop = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0
        )
        var layoutBottom = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        var layoutLeft = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Left,
            multiplier: 1.0,
            constant: 0.0
        )
        var layoutRight = NSLayoutConstraint(
            item: childView,
            attribute: NSLayoutAttribute.Right,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: 0.0
        )
        var layoutConstraints: [NSLayoutConstraint] = [
            layoutTop, layoutBottom, layoutLeft, layoutRight
        ]
        self.addConstraints(layoutConstraints)
        self.layoutIfNeeded()
    }

    func centerFrameInUIView(view: UIView) -> CGRect {
        var width: CGFloat = view.frame.size.width
        var height: CGFloat = view.frame.size.height
        var marginX: CGFloat = self.frame.size.width - width
        var marginY: CGFloat = self.frame.size.height - height
        return CGRectMake(marginX/2.0, marginY/2.0, width, height)
    }

}
