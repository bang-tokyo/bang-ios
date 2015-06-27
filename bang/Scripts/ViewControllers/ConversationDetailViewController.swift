//
//  ConversationDetailViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ConversationDetailViewController: UIViewController {

    class func build(conversationId: Int) -> (UINavigationController, ConversationDetailViewController) {
        var storyboard = UIStoryboard(name: "ConversationDetail", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var conversationDetailViewController = navigationViewController.topViewController as! ConversationDetailViewController
        conversationDetailViewController.conversationId = conversationId
        return (navigationViewController, conversationDetailViewController)
    }

    var conversationId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
