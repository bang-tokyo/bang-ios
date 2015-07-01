//
//  KeyboardDisplayDetector.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/27.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class KeyboardDisplayDetector: NSObject {
    enum DetectorType: Int {
        case Show = 1, Hide
    }

    typealias Callback = (CGFloat, DetectorType) -> ()

    private weak var view: UIView!
    private let callback: Callback

    init(view: UIView, callback: Callback) {
        self.view = view
        self.callback = callback

        super.init()

        let center = NSNotificationCenter.defaultCenter()
        center.replaceObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification)
        center.replaceObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func keyboardWillShow(notification: NSNotification) {
        keyboardWillChangeFrameWithNotification(notification, .Show)
    }

    func keyboardWillHide(notification: NSNotification) {
        keyboardWillChangeFrameWithNotification(notification, .Hide)
    }

    private func keyboardWillChangeFrameWithNotification(notification: NSNotification, _ detectorType: DetectorType) {
        let userInfo = notification.userInfo!
        let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size

        self.callback(keyboardSize.height, detectorType)

        view.setNeedsUpdateConstraints()

        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            [weak self] () -> Void in
            self?.view.layoutIfNeeded()
            return
        }, completion: nil)
    }
}
