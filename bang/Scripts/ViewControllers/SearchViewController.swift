//
//  SearchViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    class func build() -> SearchViewController {
        var storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        return storyboard.instantiateInitialViewController() as SearchViewController
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var swipteUpGesture: UISwipeGestureRecognizer!

    var centralManager: BLECentralManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = BLECentralManager.sharedInstance
        centralManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickProfileButton(sender: UIBarButtonItem) {
        var profileViewController = ProfileViewController.build()
        profileViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(profileViewController)
    }

    @IBAction func onClickContactButton(sender: UIBarButtonItem) {
        var contactViewController = ContactViewController.build()
        contactViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(contactViewController)
    }

    @IBAction func swipeUp(sender: AnyObject) {
        var rand: Int = Int(arc4random_uniform(10))
        label.text = "\(rand)"
    }

}

// MARK: - BLECentralManagerDelegate
extension SearchViewController: BLECentralManagerDelegate {
    func readyForScan() {
        label.text = "検索可能"
        swipteUpGesture.enabled = true
    }

    func notReadyForScan() {
        label.text = "検索準備"
        swipteUpGesture.enabled = false
    }
}
