//
//  ConversationDetailViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import HPGrowingTextView

class ConversationDetailViewController: UIViewController {

    class func build(conversationId: Int) -> (UINavigationController, ConversationDetailViewController) {
        var storyboard = UIStoryboard(name: "ConversationDetail", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var conversationDetailViewController = navigationViewController.topViewController as! ConversationDetailViewController
        conversationDetailViewController.conversationId = conversationId
        return (navigationViewController, conversationDetailViewController)
    }

    private struct Const {
        static let DefaultBottomPadding: CGFloat = 0.0
        static let MinMessageLength: Int = 5
        static let MaxMessageLength: Int = 100
    }

    @IBOutlet weak var growingTextView: HPGrowingTextView!
    @IBOutlet weak var growingTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!

    var conversationId: Int!

    private var detector: KeyboardDisplayDetector!


    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()

        setUpgrowingTextView()
        sendButton.enabled = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        detector = KeyboardDisplayDetector(view: view, callback: {
            [weak self] (value, detectType) -> () in

            switch detectType {
            case .Show:
                self?.footerBottomConstraint.constant = value + Const.DefaultBottomPadding
            case .Hide:
                self?.footerBottomConstraint.constant = Const.DefaultBottomPadding
            }
        })
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        detector = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tappedMainView(sender: UITapGestureRecognizer) {
        growingTextView.resignFirstResponder()
    }

    @IBAction func onClickCloseButton(sender: UIButton) {
        println("-> \(messageString())")
        growingTextView.resignFirstResponder()
    }
}

// MARK: - Private functions
extension ConversationDetailViewController {
    private func messageString() -> String {
        return growingTextView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

// MARK : - HPGrowingTextViewDelegate
extension ConversationDetailViewController: HPGrowingTextViewDelegate {
    private func setUpgrowingTextView() {
        growingTextView.delegate = self

        growingTextView.font = UIFont.systemFontOfSize(14)
        growingTextView.isScrollable = false

        growingTextView.contentInset = UIEdgeInsetsMake(0, 2.5, 0, 2.5)
        growingTextView.minNumberOfLines = 1
        growingTextView.maxNumberOfLines = 5

        growingTextView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
        growingTextView.internalTextView.textColor = UIColor.blackColor()
        growingTextView.internalTextView.backgroundColor = UIColor.clearColor()
        growingTextView.internalTextView.tintColor = UIColor.blueColor()

        growingTextView.layer.borderWidth = 1
        growingTextView.layer.cornerRadius = 8
        growingTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        growingTextView.backgroundColor = UIColor.whiteColor()
        growingTextView.clipsToBounds = true
    }

    func growingTextView(growingTextView: HPGrowingTextView!, willChangeHeight height: Float) {
        growingTextViewHeightConstraint.constant -= growingTextView.frame.size.height - CGFloat(height)
        view.updateConstraintsIfNeeded()
        UIView.animateWithDuration(0, animations: {
            () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    func growingTextViewDidChange(growingTextView: HPGrowingTextView!) {
        var textCount = count(messageString())
        sendButton.enabled =
               textCount >= Const.MinMessageLength
            && textCount <= Const.MaxMessageLength
    }
}
