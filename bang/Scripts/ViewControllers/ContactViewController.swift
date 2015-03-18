//
//  ContactViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    class func build() -> ContactViewController {
        var storyboard = UIStoryboard(name: "Contact", bundle: nil)
        return storyboard.instantiateInitialViewController() as ContactViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickSearchButton(sender: UIBarButtonItem) {
        var searchViewController = SearchViewController.build()
        searchViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(searchViewController)
    }
}
