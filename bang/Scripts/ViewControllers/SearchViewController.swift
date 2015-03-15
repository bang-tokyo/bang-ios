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
    @IBOutlet weak var peripheralButton: UIButton!
    @IBOutlet weak var swipteUpGesture: UISwipeGestureRecognizer!

    var centralManager: BLECentralManager!
    var peripheralManager: BLEPeripheralManager!
    private var isAdvertising: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = BLECentralManager.sharedInstance
        centralManager.delegate = self

        peripheralButton.enabled = false
        peripheralManager = BLEPeripheralManager.sharedInstance
        peripheralManager.delegate = self
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

    @IBAction func onClickPeripheralButton(sender: UIButton) {
        if (isAdvertising) {
            peripheralManager.stopAdvertising()
        } else {
            peripheralManager.startAdvertising()
        }
        togglePeripheralButton()
    }

    @IBAction func swipeUp(sender: AnyObject) {
        label.text = "Scaning..."
        centralManager.startScanning()
    }
}

// MARK: - BLECentralManagerDelegate
extension SearchViewController: BLECentralManagerDelegate {
    func readyForScan() {
        label.text = "Ready For Search"
        swipteUpGesture.enabled = true
    }

    func notReadyForScan() {
        label.text = "Not Ready For Search"
        swipteUpGesture.enabled = false
    }
}

extension SearchViewController: BLEPeripheralManagerDelegate {
    func readyForAdvertise() {
        togglePeripheralButton()
        peripheralButton.enabled = true
    }
}

// MARK: - Private functions
extension SearchViewController {
    func togglePeripheralButton() {
        isAdvertising = !isAdvertising
        peripheralButton.setTitle(
            isAdvertising
                ? "Stop Advertising"
                : "Start Advertising"
            , forState: UIControlState.Normal
        )
    }
}
